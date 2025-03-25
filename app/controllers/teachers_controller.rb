class TeachersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def index
    @teachers = Teacher.includes(:user, :school_classes, :school_classes => :moment)
    @teachers = @teachers.where("users.firstname LIKE ? OR users.lastname LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%") if params[:query].present?
  end

  def show
    @teacher = Teacher.includes(:user, :school_classes, [:school_classes => :moment]).find(params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def edit
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to @teacher, notice: 'Teacher was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: 'Teacher was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @teacher.destroy
    redirect_to teachers_url, notice: 'Teacher was successfully deleted.'
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:firstname, :lastname, :email, :phone_number, :iban)
  end
end 