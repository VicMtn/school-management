module Admin
  class CoursesController < BaseController
    before_action :set_course, only: [:edit, :update, :destroy]

    def index
      @courses = Course.all
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      if @course.save
        flash[:notice] = "Course was successfully created."
        redirect_to admin_courses_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @course.update(course_params)
        flash[:notice] = "Course was successfully updated."
        redirect_to admin_courses_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @course.destroy
      flash[:notice] = "Course was successfully deleted."
      redirect_to admin_courses_path
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :description)
    end
  end
end 