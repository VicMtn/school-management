class TeachersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def index
    @teachers = Teacher.all.includes(:user, :school_classes, :school_classes => :moment)
    
    if params[:query].present?
      @teachers = Teacher.where("firstname LIKE :query OR lastname LIKE :query", 
                              query: "%#{params[:query]}%")
                        .includes(:user, :school_classes, :school_classes => :moment)
    end
  end

  def show
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
    @teacher.soft_delete
    redirect_to teachers_url, notice: 'Teacher was successfully archived.'
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:firstname, :lastname, :birthdate, :gender, :address_id)
  end
end 