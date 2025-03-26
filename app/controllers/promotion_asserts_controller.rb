class PromotionAssertsController < ApplicationController
  before_action :set_promotion_assert, only: %i[ show edit update destroy ]
  before_action :require_admin, except: [:index, :show]

  # GET /promotion_asserts or /promotion_asserts.json
  def index
    @promotion_asserts = PromotionAssert.all
  end

  # GET /promotion_asserts/1 or /promotion_asserts/1.json
  def show
  end

  # GET /promotion_asserts/new
  def new
    @promotion_assert = PromotionAssert.new
    load_collections
  end

  # GET /promotion_asserts/1/edit
  def edit
    load_collections
  end

  # POST /promotion_asserts or /promotion_asserts.json
  def create
    @promotion_assert = PromotionAssert.new(promotion_assert_params)

    if @promotion_assert.save
      redirect_to promotion_asserts_path, notice: 'Promotion assert was successfully created.'
    else
      load_collections
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /promotion_asserts/1 or /promotion_asserts/1.json
  def update
    if @promotion_assert.update(promotion_assert_params)
      redirect_to promotion_asserts_path, notice: 'Promotion assert was successfully updated.'
    else
      load_collections
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /promotion_asserts/1 or /promotion_asserts/1.json
  def destroy
    @promotion_assert.destroy
    redirect_to promotion_asserts_path, notice: 'Promotion assert was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion_assert
      @promotion_assert = PromotionAssert.includes(:moment, :sector).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def promotion_assert_params
      params.require(:promotion_assert).permit(:description, :function, :moment_id, :sector_id)
    end
    
    def load_collections
      @moments = Moment.all.order(start_on: :desc)
      @sectors = Sector.all.order(:name)
    end
end
