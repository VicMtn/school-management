module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin_access

    private

    def check_admin_access
      unless current_user&.person&.dean?
        flash[:error] = "You are not authorized to access this area."
        redirect_to root_path
      end
    end
  end
end 