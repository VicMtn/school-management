class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses or /courses.json
  def index
    if user_signed_in? && current_user.person&.type == 'Student'
      @current_class = current_user.person.current_class
      @courses = @current_class.courses.includes(:subject, :teacher).order(:start_at)
    else
      @courses = Course.all.includes(:subject, :teacher, :school_class).order(:start_at)
    end
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.soft_delete
    redirect_to courses_url, notice: 'Course was successfully archived.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:start_at, :end_at, :archived, :subject_id, :school_class_id, :moment_id, :teacher_id)
    end
end
