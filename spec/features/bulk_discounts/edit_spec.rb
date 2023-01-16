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
      save_and_open_page
      expect(page).to have_field("Discount percentage")
      # # And I see that the discounts current attributes are pre-poluated in the form
      expect(page).to have_content(@discount1.discount_percentage)
      
      expect(page).to have_field("Quantity threshold")
      expect(page).to have_content(@discount1.quantity_threshold)
      
      # # When I change any/all of the information and click submit
      fill_in 'Discount percentage', with: 15
      fill_in 'Quantity threshold', with: 20
      expect(page).to have_button("Submit")
      
      # # Then I am redirected to the bulk discount's show page
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
      
      # # And I see that the discount's attributes have been updated
      within ("#discount-#{@discount1.id}") do
        expect(page).to have_content(15)
        expect(page).to have_content(20)
      end
    end
  end
end