class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
  end

  def require_admin
    unless current_user&.person&.dean?
      flash[:error] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  def admin_area?
    current_user&.person&.dean?
  end
  helper_method :admin_area?
end
