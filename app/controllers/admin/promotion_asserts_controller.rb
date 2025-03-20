module Admin
  class PromotionAssertsController < BaseController
    before_action :set_promotion_assert, only: [:edit, :update, :destroy]

    def index
      @promotion_asserts = PromotionAssert.all
    end

    def new
      @promotion_assert = PromotionAssert.new
    end

    def create
      @promotion_assert = PromotionAssert.new(promotion_assert_params)
      if @promotion_assert.save
        flash[:notice] = "Promotion was successfully created."
        redirect_to admin_promotion_asserts_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @promotion_assert.update(promotion_assert_params)
        flash[:notice] = "Promotion was successfully updated."
        redirect_to admin_promotion_asserts_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @promotion_assert.destroy
      flash[:notice] = "Promotion was successfully deleted."
      redirect_to admin_promotion_asserts_path
    end

    private

    def set_promotion_assert
      @promotion_assert = PromotionAssert.find(params[:id])
    end

    def promotion_assert_params
      params.require(:promotion_assert).permit(:name, :description, :start_date, :end_date)
    end
  end
end 