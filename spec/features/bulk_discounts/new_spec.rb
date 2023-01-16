require 'rails_helper'

RSpec.describe 'bulk discount show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = BulkDiscount.create!(discount_percentage: 5, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(discount_percentage: 10, quantity_threshold: 20, merchant_id: @merchant1.id)
    visit new_merchant_bulk_discount_path(@merchant1)
  end
  
  describe 'user story 2' do
    # # As a merchant
    # # When I visit my bulk discounts index
    # # Then I see a link to create a new discount
    # # When I click this link
    # # Then I am taken to a new page where I see a form to add a new bulk discount
    it 'has a form' do
      expect(page).to have_field("Discount percentage")
      expect(page).to have_field("Quantity threshold")
      expect(page).to have_button("Submit")
    end
    
    it 'can fill in the form' do
      # # When I fill in the form with valid data
      fill_in 'Discount percentage', with: 30
      fill_in 'Quantity threshold', with: 50
      
      click_on 'Submit'
      
      # # Then I am redirected back to the bulk discount index
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      
      expect(page).to have_content('5%')
      expect(page).to have_content('10')
      
      expect(page).to have_content('10%')
      expect(page).to have_content('20')
      
      expect('5%').to appear_before('30%')
      
      expect(page).to have_content('30%')
      expect(page).to have_content('50')
      
      # # And I see my new bulk discount listed
    end
  end
end