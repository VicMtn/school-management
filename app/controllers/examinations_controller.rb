class ExaminationsController < ApplicationController
  before_action :set_examination, only: %i[ show edit update destroy ]
  before_action :prevent_teacher_edit, only: %i[ edit update destroy ]

  # GET /examinations or /examinations.json
  def index
    if current_user.person&.type == 'Teacher'
      teacher = current_user.person
      @examinations = Examination.joins(:course)
                               .where(courses: { teacher_id: teacher.id })
                               .includes(:course)
    else
      @examinations = Examination.all.includes(:course)
    end
  end

  # GET /examinations/1 or /examinations/1.json
  def show
  end

  # GET /examinations/new
  def new
    @examination = Examination.new
  end

  # GET /examinations/1/edit
  def edit
  end

  # POST /examinations or /examinations.json
  def create
    @examination = Examination.new(examination_params)

    respond_to do |format|
      if @examination.save
        format.html { redirect_to @examination, notice: "Examination was successfully created." }
        format.json { render :show, status: :created, location: @examination }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /examinations/1 or /examinations/1.json
  def update
    respond_to do |format|
      if @examination.update(examination_params)
        format.html { redirect_to @examination, notice: "Examination was successfully updated." }
        format.json { render :show, status: :ok, location: @examination }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /examinations/1 or /examinations/1.json
  def destroy
    @examination.soft_delete

    respond_to do |format|
      format.html { redirect_to examinations_path, status: :see_other, notice: "Examination was successfully archived." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_examination
      @examination = Examination.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def examination_params
      params.require(:examination).permit(:title, :effective_date, :course_id)
    end

    def prevent_teacher_edit
      if current_user.person&.type == 'Teacher'
        flash[:alert] = "Teachers are not allowed to modify examinations"
        redirect_to examinations_path
      end
    end
end
