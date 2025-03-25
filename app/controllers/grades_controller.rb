class GradesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grade, only: [:show, :edit, :update, :destroy]

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
    @grade = Grade.new(grade_params)

    if @grade.save
      redirect_to @grade, notice: 'Grade was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grades/1 or /grades/1.json
  def update
    if @grade.update(grade_params)
      redirect_to @grade, notice: 'Grade was successfully updated.'
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
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grade_params
      params.require(:grade).permit(:score, :execution_date, :student_id, :examination_id)
    end
end
