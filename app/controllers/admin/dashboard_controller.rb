module Admin
  class DashboardController < ApplicationController
    before_action :require_admin
    
    def index
      @active_tab = params[:tab] || 'people'
      
      if @active_tab == 'subjects'
        redirect_to subjects_path
        return
      elsif @active_tab == 'courses'
        redirect_to courses_path
        return
      end
      
      case @active_tab
      when 'people'
        @resources = Person.all
      when 'promotion_asserts'
        @resources = PromotionAssert.all
      end
    end
  end
end