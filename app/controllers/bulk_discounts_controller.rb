class BulkDiscountsController < ApplicationController
  before_action :current_merchant
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @discount = BulkDiscount.find(params[:id])
  end
  
  private
    def current_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

    def discount_params
      params.require(:bulk_discount).permit(:discount_percentage, :quantity_threshold)
    end
end