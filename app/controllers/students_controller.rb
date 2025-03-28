class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit, :update, :destroy, :grade_report, :promotion_check]
  before_action :authorize_student_access, only: [:promotion_check]

  def index
    @students = Student.includes(:user, :school_classes => [:moment, :master])
    
    if params[:query].present?
      @students = Student.where("firstname LIKE :query OR lastname LIKE :query", 
                              query: "%#{params[:query]}%")
                        .includes(:user, :school_classes => [:moment, :master])
    end
    
    # Préchargement explicite des données pour le debugging
    @students.each do |student|
      student.debug_class_info  # Cette méthode ne fait rien mais force le préchargement
    end
  end

  def show
    @student = Student.includes(:user, :school_classes, :school_classes => [:moment, :master], 
                              :grades => [:examination => [:course => :subject]]).find(params[:id])
  end

  def promotion_check
    @student = Student.includes(:school_classes, :grades => [:examination => [:course => [:subject => :sector]]]).find(params[:id])
    
    if params[:moment_id].present?
      @moment = Moment.find(params[:moment_id])
    else
      @moment = @student.current_class&.moment
    end
    
    if @moment
      @promotion_results = @student.promotion_results(@moment)
    else
      @promotion_results = { promoted: false, reason: "No moment selected" }
    end
    
    @moments = Moment.order(start_on: :desc)
  end

  def grade_report
    @student = Student.includes(:school_classes, :school_classes => [:moment, :master], 
                               :grades => [:examination => [:course => [:subject => :sector]]]).find(params[:id])
    
    # Récupérer le moment pour le bulletin (actuel par défaut)
    if params[:moment_id].present?
      @moment = Moment.find(params[:moment_id])
    else
      @moment = @student.current_class&.moment
    end
    
    # Calculer les résultats de promotion si le moment est disponible
    if @moment
      @promotion_results = @student.promotion_results(@moment)
    end
    
    respond_to do |format|
      format.html
      format.pdf do
        require 'prawn'
        require 'prawn/table'
        
        pdf = Prawn::Document.new
        
        # En-tête du document
        pdf.font_size(18) { pdf.text "Bulletin de notes", align: :center, style: :bold }
        pdf.move_down 10
        pdf.font_size(12) { pdf.text "Période: #{@moment&.uid || 'Non définie'}", align: :center }
        pdf.move_down 20
        
        # Informations sur l'étudiant
        pdf.font_size(14) { pdf.text "Informations de l'élève", style: :bold }
        pdf.move_down 5
        pdf.text "Nom et prénom: #{@student.full_name}"
        pdf.text "Email: #{@student.email}"
        pdf.text "Classe: #{@student.current_class&.name || 'Non assigné'}"
        if @student.current_class&.master
          pdf.text "Enseignant responsable: #{@student.current_class.master.full_name}"
        end
        pdf.move_down 20
        
        # Tableau des notes
        if @student.grades.any?
          pdf.font_size(14) { pdf.text "Notes", style: :bold }
          pdf.move_down 10
          
          grades_data = [["Matière", "Secteur", "Note", "Date"]]
          
          # Filtrer les notes pour le moment sélectionné
          relevant_grades = if @moment
            @student.grades.joins(examination: { course: :moment }).where(courses: { moment_id: @moment.id })
          else
            @student.grades
          end
          
          relevant_grades.includes(:examination => [:course => [:subject => :sector]]).order(execute_on: :desc).each do |grade|
            grades_data << [
              grade.examination.course.subject.name,
              grade.examination.course.subject.sector&.name || "N/A",
              grade.value.to_s,
              grade.execute_on.strftime("%d/%m/%Y")
            ]
          end
          
          if grades_data.size > 1
            pdf.table(grades_data, header: true, width: pdf.bounds.width) do |table|
              table.row(0).font_style = :bold
              table.row(0).background_color = "DDDDDD"
              table.cells.padding = [5, 10, 5, 10]
              table.column_widths = [pdf.bounds.width * 0.35, pdf.bounds.width * 0.25, pdf.bounds.width * 0.15, pdf.bounds.width * 0.25]
            end
          else
            pdf.text "Aucune note enregistrée pour cette période.", style: :italic
          end
          
          # Information de promotion
          if @promotion_results.present?
            pdf.move_down 20
            pdf.font_size(14) { pdf.text "Résultats de promotion", style: :bold }
            pdf.move_down 10
            
            if @promotion_results[:promoted]
              pdf.text "DÉCISION : PROMU", style: :bold, color: "008000" # Vert
            else
              pdf.text "DÉCISION : NON PROMU", style: :bold, color: "FF0000" # Rouge
              if @promotion_results[:reason].present?
                pdf.text "Raison : #{@promotion_results[:reason]}", color: "FF0000"
              end
            end
            
            if @promotion_results[:sector_results].present?
              pdf.move_down 10
              secteur_data = [["Secteur", "Moyenne", "Exigence", "Résultat"]]
              
              @promotion_results[:sector_results].each do |sector_name, result|
                secteur_data << [
                  sector_name,
                  result[:grade] ? result[:grade].round(2).to_s : "N/A",
                  result[:function].capitalize,
                  result[:meets_requirement] ? "Réussi" : "Échec"
                ]
              end
              
              pdf.table(secteur_data, header: true, width: pdf.bounds.width) do |table|
                table.row(0).font_style = :bold
                table.row(0).background_color = "DDDDDD"
                table.cells.padding = [5, 10, 5, 10]
              end
            end
          end
        else
          pdf.text "Aucune note enregistrée pour cet élève.", style: :italic
        end
        
        # Pied de page
        pdf.move_down 30
        pdf.text "Document généré le #{Date.current.strftime('%d/%m/%Y')}", align: :right, size: 8
        
        send_data pdf.render, filename: "bulletin_#{@student.full_name.parameterize}.pdf",
                             type: "application/pdf",
                             disposition: "inline"
      end
    end
  end

  def new
    @student = Student.new
    @school_classes = SchoolClass.includes(:moment, :master).all
  end

  def edit
    @school_classes = SchoolClass.includes(:moment, :master).all
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      # Handle class assignment separately
      if params[:student][:school_class_id].present?
        school_class = SchoolClass.find(params[:student][:school_class_id])
        @student.school_classes << school_class
      end
      redirect_to @student, notice: 'Student was successfully created.'
    else
      @school_classes = SchoolClass.includes(:moment, :master).all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      # Handle class assignment separately
      if params[:student][:school_class_id].present?
        school_class = SchoolClass.find(params[:student][:school_class_id])
        # Remove existing class associations
        @student.students_classes.destroy_all
        # Create new association
        @student.school_classes << school_class
      end
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      @school_classes = SchoolClass.includes(:moment, :master).all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.soft_delete
    redirect_to students_url, notice: 'Student was successfully archived.'
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:firstname, :lastname, :address_id, :email, :phone_number, :iban)
  end
  
  def authorize_student_access
    # Vérifie si l'utilisateur connecté est l'élève lui-même ou un autre utilisateur autorisé (dean, admin)
    unless current_user.person == @student || current_user.person&.type == "Dean" || current_user.person&.type == "Teacher"
      flash[:alert] = "Vous n'êtes pas autorisé à accéder à cette page."
      redirect_to root_path
    end
  end
end 