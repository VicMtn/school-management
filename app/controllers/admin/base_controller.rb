class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_dean!

  private

  def ensure_dean!
    unless current_user&.person&.type == 'Dean'
      flash[:alert] = "You are not authorized to access this area."
      redirect_to root_path
    end
  end
end 