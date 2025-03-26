class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit, :update, :destroy, :grade_report]

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

  def grade_report
    @student = Student.includes(:school_classes, :school_classes => [:moment, :master], 
                               :grades => [:examination => [:course => :subject]]).find(params[:id])
    
    respond_to do |format|
      format.pdf do
        require 'prawn'
        require 'prawn/table'
        
        pdf = Prawn::Document.new
        
        # En-tête du document
        pdf.font_size(18) { pdf.text "Bulletin de notes", align: :center, style: :bold }
        pdf.move_down 10
        pdf.font_size(12) { pdf.text "Année scolaire: #{@student.current_class&.moment&.start_on&.year || Date.current.year}", align: :center }
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
          
          grades_data = [["Matière", "Note", "Date"]]
          
          @student.grades.includes(:examination => [:course => :subject]).order(execute_on: :desc).each do |grade|
            grades_data << [
              grade.examination.course.subject.name,
              grade.value.to_s,
              grade.execute_on.strftime("%d/%m/%Y")
            ]
          end
          
          pdf.table(grades_data, header: true, width: pdf.bounds.width) do |table|
            table.row(0).font_style = :bold
            table.row(0).background_color = "DDDDDD"
            table.cells.padding = [5, 10, 5, 10]
            table.column_widths = [pdf.bounds.width * 0.5, pdf.bounds.width * 0.2, pdf.bounds.width * 0.3]
          end
          
          # Calcul de la moyenne
          average = @student.grades.average(:value)&.round(2)
          pdf.move_down 10
          if average.present? && average >= 12 
            pdf.text "Moyenne générale: #{average}", style: :bold, color: "008000" # Vert
            pdf.move_down 10
            pdf.text "Vous êtes promu au semestre suivant", style: :bold
          elsif average.present? && average < 12
            pdf.text "Moyenne générale: #{average}", style: :bold, color: "FF0000" # Rouge
            pdf.move_down 10
            pdf.text "Vous n'êtes pas promu au semestre suivant", style: :bold
          else
            pdf.text "Aucune note enregistrée pour cet élève.", style: :italic
          end
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
end 