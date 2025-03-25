class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all.includes(:user, :school_classes, :school_classes => :moment)
    
    if params[:query].present?
      @students = Student.where("firstname LIKE :query OR lastname LIKE :query", 
                              query: "%#{params[:query]}%")
                        .includes(:user, :school_classes, :school_classes => :moment)
    end
  end

  def show
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to @student, notice: 'Student was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
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
    params.require(:student).permit(:firstname, :lastname, :birthdate, :gender, :address_id, :school_class_id)
  end
end 