class SchoolClassesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school_class, only: [:show, :edit, :update, :destroy]

  # GET /school_classes or /school_classes.json
  def index
    if user_signed_in? && current_user.person&.type == 'Student'
      @current_class = current_user.person.current_class
      @classmates = @current_class.students.order(:lastname)
    else
      @school_classes = SchoolClass.all.includes(:moment).order(:name)
    end
  end

  # GET /school_classes/1 or /school_classes/1.json
  def show
  end

  # GET /school_classes/new
  def new
    @school_class = SchoolClass.new
  end

  # GET /school_classes/1/edit
  def edit
  end

  # POST /school_classes or /school_classes.json
  def create
    @school_class = SchoolClass.new(school_class_params)

    if @school_class.save
      redirect_to @school_class, notice: 'School class was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /school_classes/1 or /school_classes/1.json
  def update
    if @school_class.update(school_class_params)
      redirect_to @school_class, notice: 'School class was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /school_classes/1 or /school_classes/1.json
  def destroy
    @school_class.soft_delete
    redirect_to school_classes_url, notice: 'School class was successfully archived.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_class
      @school_class = SchoolClass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def school_class_params
      params.require(:school_class).permit(:name, :moment_id)
    end
end
