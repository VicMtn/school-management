class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  # GET /subjects or /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1 or /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects or /subjects.json
  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to subjects_path, notice: 'Subject was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subjects/1 or /subjects/1.json
  def update
    if @subject.update(subject_params)
      redirect_to subjects_path, notice: 'Subject was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /subjects/1 or /subjects/1.json
  def destroy
    @subject.destroy
    redirect_to subjects_path, notice: 'Subject was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subject_params
      params.require(:subject).permit(:name, :description, :course_id)
    end
end
