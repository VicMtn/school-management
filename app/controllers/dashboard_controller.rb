class DashboardController < ApplicationController
  def index
    @total_students = Student.count
    @total_teachers = Teacher.count
    @total_deans = Dean.count
    @total_courses = Course.count
  end
end 