class DeansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dean, only: [:show, :edit, :update, :destroy, :schedule]

  def index
    @deans = Dean.all
  end

  def show
    @dean = Dean.includes(:school_classes).find(params[:id])
  end

  def schedule
    @dean = Dean.includes(:school_classes, :courses).find(params[:id])
    @courses = @dean.courses.includes(:subject, :school_class).order(:start_at)
  end

  def new
    @dean = Dean.new
  end

  def edit
  end

  def create
    @dean = Dean.new(dean_params)

    if @dean.save
      redirect_to @dean, notice: 'Dean was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @dean.update(dean_params)
      redirect_to @dean, notice: 'Dean was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dean.destroy
    redirect_to deans_url, notice: 'Dean was successfully deleted.'
  end

  private

  def set_dean
    @dean = Dean.find(params[:id])
  end

  def dean_params
    params.require(:dean).permit(:firstname, :lastname, :email, :phone_number, :iban)
  end
end 