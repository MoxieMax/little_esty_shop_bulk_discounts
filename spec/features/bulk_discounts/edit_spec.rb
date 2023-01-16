require 'rails_helper'

RSpec.describe 'bulk discount show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    
    @discount1 = BulkDiscount.create!(discount_percentage: 11, quantity_threshold: 10, merchant_id: @merchant1.id)
    
    visit edit_merchant_bulk_discount_path(@merchant1, @discount1)
  end
  
  describe 'user story 5 #edit' do
    # # As a merchant
    # # When I visit my bulk discount show page
    # # Then I see a link to edit the bulk discount
    # # When I click this link
    it 'the edit page populates with filled fields' do
      save_and_open_page
      # # Then I am taken to a new page with a form to edit the discount
      # # And I see that the discounts current attributes are pre-poluated in the form
      expect(page).to have_field("Discount percentage", with: 11)
      
      
      expect(page).to have_field("Quantity threshold", with: 10)
    end
      
    it 'can have the form filled in and submitted' do
      # # When I change any/all of the information and click submit
      fill_in 'Discount percentage', with: 15
      fill_in 'Quantity threshold', with: 20
      expect(page).to have_button("Submit")
      
      # # Then I am redirected to the bulk discount's show page
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
      
      click_on "Submit"
      
      # # And I see that the discount's attributes have been updated
      expect(page).to have_content(15)
      expect(page).to have_content(20)
    end
  end
end