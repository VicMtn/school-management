class GradesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_examination, except: [:index]
  before_action :set_grade, only: [:edit, :update]
  before_action :set_student, only: [:edit, :create, :update]

  # GET /grades or /grades.json
  def index
    if user_signed_in? && current_user.person&.type == 'Student'
      @grades = current_user.person.grades.includes(:examination).order(execution_date: :desc)
    else
      @grades = Grade.all.includes(:student, :examination).order(execution_date: :desc)
    end
  end

  # GET /grades/1 or /grades/1.json
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades or /grades.json
  def create
    @grade = @examination.grades.build(grade_params)
    @grade.student = @student

    if @grade.save
      redirect_to examination_path(@examination), notice: 'Grade was successfully created.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grades/1 or /grades/1.json
  def update
    @grade = @examination.grades.find_by(student_id: @student.id)
    
    if @grade.nil?
      @grade = @examination.grades.build(student: @student)
    end

    if @grade.update(grade_params)
      redirect_to examination_path(@examination), notice: 'Grade was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /grades/1 or /grades/1.json
  def destroy
    @grade.soft_delete
    redirect_to grades_url, notice: 'Grade was successfully archived.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_examination
      @examination = Examination.find(params[:examination_id])
    end

    def set_grade
      @grade = @examination.grades.find_or_initialize_by(student_id: params[:student_id])
    end

    def set_student
      @student = Student.find(params[:student_id] || grade_params[:student_id])
    end

    # Only allow a list of trusted parameters through.
    def grade_params
      params.require(:grade).permit(:value, :student_id)
    end
end
