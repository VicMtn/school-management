module Admin
  class SubjectsController < BaseController
    before_action :set_subject, only: [:edit, :update, :destroy]

    def index
      @subjects = Subject.all
    end

    def new
      @subject = Subject.new
    end

    def create
      @subject = Subject.new(subject_params)
      if @subject.save
        flash[:notice] = "Subject was successfully created."
        redirect_to admin_subjects_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @subject.update(subject_params)
        flash[:notice] = "Subject was successfully updated."
        redirect_to admin_subjects_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @subject.destroy
      flash[:notice] = "Subject was successfully deleted."
      redirect_to admin_subjects_path
    end

    private

    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:name, :description, :course_id)
    end
  end
end 