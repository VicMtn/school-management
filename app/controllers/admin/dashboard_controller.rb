module Admin
  class DashboardController < ApplicationController
    before_action :require_admin
    
    def index
      @active_tab = params[:tab] || 'people'
      
      case @active_tab
      when 'people'
        @resources = Person.all
      when 'courses'
        @resources = Course.all
      when 'subjects'
        @resources = Subject.all
      when 'promotion_asserts'
        @resources = PromotionAssert.all
      end
    end
  end
end