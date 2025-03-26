class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy, :restore]
  before_action :require_admin, except: [:index, :show]

  # GET /subjects or /subjects.json
  def index
    if params[:show_archived]
      @subjects = Subject.unscoped.where.not(deleted_at: nil)
    else
      @subjects = Subject.all
    end
  end

  # GET /subjects/1 or /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
    load_teachers
  end

  # GET /subjects/1/edit
  def edit
    load_teachers
  end

  # POST /subjects or /subjects.json
  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to subjects_path, notice: 'Subject was successfully created.'
    else
      load_teachers
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subjects/1 or /subjects/1.json
  def update
    if @subject.update(subject_params)
      redirect_to subjects_path, notice: 'Subject was successfully updated.'
    else
      load_teachers
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /subjects/1 or /subjects/1.json
  def destroy
    @subject.soft_delete
    redirect_to subjects_path, notice: 'Subject was successfully archived.'
  end

  # PATCH/PUT /subjects/1/restore or /subjects/1/restore.json
  def restore
    @subject.restore
    redirect_to subjects_path(show_archived: true), notice: 'Subject was successfully restored.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subject_params
      params.require(:subject).permit(:name, :slug, :teacher_id)
    end
    
    def load_teachers
      @teachers = Teacher.all.order(:lastname, :firstname)
    end
end
