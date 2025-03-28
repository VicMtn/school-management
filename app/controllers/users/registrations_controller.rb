module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :check_dean_permissions
    
    private

    def check_dean_permissions
      unless current_user&.person&.type == 'Dean'
        flash[:alert] = "Only Deans can modify user accounts."
        redirect_to root_path
      end
    end
  end
end 