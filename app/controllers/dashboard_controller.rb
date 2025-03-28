class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in? && current_user.person&.type == 'Student'
      @current_class = current_user.person.current_class
      @current_courses = @current_class.courses.includes(:subject, :teacher).order(:start_at)
      @grades = current_user.person.grades.includes(:examination).order(execution_date: :desc).limit(5)
    else
      @total_students = Student.count
      @total_teachers = Teacher.count
      @total_deans = Dean.count
      @total_courses = Course.count
    end
  end
end 