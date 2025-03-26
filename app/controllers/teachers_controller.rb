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
    @subjects = Subject.all
    @school_classes = SchoolClass.includes(:moment).all
  end

  def edit
    @subjects = Subject.all
    @school_classes = SchoolClass.includes(:moment).all
  end

  def create
    @teacher = Teacher.new(teacher_params)
    
    if @teacher.save
      # Handle subject associations
      if params[:teacher][:subject_ids].present?
        @teacher.subjects = Subject.find(params[:teacher][:subject_ids].reject(&:blank?))
      end
      
      # Handle class associations
      if params[:teacher][:school_class_ids].present?
        @teacher.school_classes = SchoolClass.find(params[:teacher][:school_class_ids].reject(&:blank?))
      end
      
      redirect_to @teacher, notice: 'Teacher was successfully created.'
    else
      @subjects = Subject.all
      @school_classes = SchoolClass.includes(:moment).all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @teacher.update(teacher_params)
      # Handle subject associations
      if params[:teacher][:subject_ids].present?
        @teacher.subjects = Subject.find(params[:teacher][:subject_ids].reject(&:blank?))
      else
        @teacher.subjects = []
      end
      
      # Handle class associations
      if params[:teacher][:school_class_ids].present?
        @teacher.school_classes = SchoolClass.find(params[:teacher][:school_class_ids].reject(&:blank?))
      else
        @teacher.school_classes = []
      end
      
      redirect_to @teacher, notice: 'Teacher was successfully updated.'
    else
      @subjects = Subject.all
      @school_classes = SchoolClass.includes(:moment).all
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