require 'rails_helper'

RSpec.describe 'bulk discount show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = BulkDiscount.create!(discount_percentage: 5, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(discount_percentage: 10, quantity_threshold: 20, merchant_id: @merchant1.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end
  
  describe 'user story 4' do
    it 'as a merchant, when I visit my bulk discounts show page' do
      # # When I visit my bulk discount show page
      visit merchant_bulk_discount_path(@merchant1.id, @discount1.id)
      
      # # Then I see the bulk discount's quantity threshold and percentage discount
      expect(page).to have_content(@discount1.discount_percentage)
      expect(page).to have_content(@discount1.quantity_threshold)
    end
    
    it 'as a merchant, when I visit my bulk discounts show page' do
      visit merchant_bulk_discount_path(@merchant1.id, @discount2.id)
      
      # # Then I see the bulk discount's quantity threshold and percentage discount
      expect(page).to have_content(@discount2.discount_percentage)
      expect(page).to have_content(@discount2.quantity_threshold)
    end
  end
  
  describe 'user story 5 #edit' do
    # # As a merchant
    # # When I visit my bulk discount show page
    it 'has a link to edit the discount' do
      visit merchant_bulk_discount_path(@merchant1.id, @discount1.id)
      # # Then I see a link to edit the bulk discount
      expect(page).to have_button("Edit Discount")
      
      # # When I click this link
      click_button "Edit Discount"
      
      # # Then I am taken to a new page with a form to edit the discount
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
      
      # #All things following go to edit_spec
    end
  end
end