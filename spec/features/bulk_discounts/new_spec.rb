require 'rails_helper'

RSpec.describe 'bulk discount show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    visit new_merchant_bulk_discount_path(@merchant1)
  end
  
  describe 'user story 2' do
    # # As a merchant
    # # When I visit my bulk discounts index
    # # Then I see a link to create a new discount
    # # When I click this link
    # # Then I am taken to a new page where I see a form to add a new bulk discount
    it 'I can fill in the form' do
      # # When I fill in the form with valid data
      
      # # Then I am redirected back to the bulk discount index
      
      # # And I see my new bulk discount listed
    end
  end
  
end