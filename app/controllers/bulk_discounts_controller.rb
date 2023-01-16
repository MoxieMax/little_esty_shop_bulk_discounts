class BulkDiscountsController < ApplicationController
  before_action :current_merchant
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @discount = BulkDiscount.find(params[:id])
  end
  
  def edit
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])

    discount.update(discount_params)
    redirect_to merchant_bulk_discount_path(@merchant, discount)
  end
  
  def new
    @discount = BulkDiscount.new
  end
  
  def create
    discount = @merchant.bulk_discounts.create(discount_params)
    discount.save
    redirect_to merchant_bulk_discounts_path(@merchant)
  end
  
  def destroy
    discount = BulkDiscount.find(params[:id])
    discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end
  
  private
    def current_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

    def discount_params
      params.require(:bulk_discount).permit(:discount_percentage, :quantity_threshold)
    end
end