require 'rails_helper'

RSpec.describe 'bulk discount show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    
    @discount1 = BulkDiscount.create!(discount_percentage: 5, quantity_threshold: 10, merchant_id: @merchant1.id)
    
    edit_merchant_bulk_discount_path(@merchant1, @discount1)
  end
  
  describe 'user story 5 #edit' do
    # # As a merchant
    # # When I visit my bulk discount show page
    # # Then I see a link to edit the bulk discount
    # # When I click this link
    it 'the edit page populates with filled forms' do
      # # Then I am taken to a new page with a form to edit the discount
      expect()
      
      # # And I see that the discounts current attributes are pre-poluated in the form
      
      # # When I change any/all of the information and click submit
      
      # # Then I am redirected to the bulk discount's show page
      
      # # And I see that the discount's attributes have been updated
    end
  end
end