class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy, :restore]
  before_action :require_admin, except: [:index, :show]

  # GET /courses or /courses.json
  def index
    if user_signed_in? && current_user.person&.type == 'Student'
      @current_class = current_user.person.current_class
      @courses = @current_class.courses.includes(:subject, :teacher).order(:start_at)
    else
      if params[:show_archived]
        @courses = Course.unscoped.where.not(deleted_at: nil).includes(:subject, :teacher, :school_class, :room).order(:start_at)
      else
        @courses = Course.all.includes(:subject, :teacher, :school_class, :room).order(:start_at)
      end
    end
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    load_collections
  end

  # GET /courses/1/edit
  def edit
    load_collections
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      load_collections
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      load_collections
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.soft_delete
    redirect_to courses_url, notice: 'Course was successfully archived.'
  end
  
  # PATCH/PUT /courses/1/restore
  def restore
    @course.restore
    redirect_to courses_path(show_archived: true), notice: 'Course was successfully restored.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.includes(:subject, :teacher, :school_class, :moment, :room).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:start_at, :end_at, :archived, :subject_id, :school_class_id, :moment_id, :teacher_id, :week_day, :room_id)
    end
    
    def load_collections
      @teachers = Teacher.all.order(:lastname, :firstname)
      @subjects = Subject.all.order(:name)
      @school_classes = SchoolClass.all.order(:name)
      @moments = Moment.all.order(start_on: :desc)
      @rooms = Room.all.order(:name)
    end
end
