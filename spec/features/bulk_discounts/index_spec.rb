require 'rails_helper'

RSpec.describe 'bulk discounts' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
    
    @discount1 = BulkDiscount.create!(discount_percentage: 13, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(discount_percentage: 15, quantity_threshold: 20, merchant_id: @merchant1.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end
  
  describe 'user story 1 #index' do
    # As a merchant
    # When I visit my merchant dashboard
    # Then I see a link to view all my discounts
    # When I click this link
    # Then I am taken to my bulk discounts index page
    it 'lists all the discounts a merchant offers' do
      # # Where I see all of my bulk discounts including their
      # # percentage discount and quantity thresholds
      within ("#discount-#{@discount1.id}") do
        expect(page).to have_content(@discount1.discount_percentage)
        expect(page).to have_content(@discount1.quantity_threshold)
        
        # # # And each bulk discount listed includes a link to its show page
        expect(page).to have_link("Discount #{@discount1.id}")
      end
      
      within ("#discount-#{@discount2.id}") do
        expect(page).to have_content(@discount2.discount_percentage)
        expect(page).to have_content(@discount2.quantity_threshold)
        
        # # # And each bulk discount listed includes a link to its show page
        expect(page).to have_link("Discount #{@discount2.id}")
        click_on "Discount #{@discount2.id}"
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1.id, @discount2.id))
      end
    end
  end
  
  describe 'user story 2 #create' do
    it 'index page has a link to create a new discount' do
      # # As a merchant
      # # When I visit my bulk discounts index
      # # Then I see a link to create a new discount
      expect(page).to have_link("Create Discount")
      
      # # When I click this link
      click_on "Create Discount"
      
      # # Then I am taken to a new page where I see a form to add a new bulk discount
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      # # Any steps after this goes to the 'new'/new_spec page
    end
  end
  
  describe 'user story 3 #delete' do
    # # As a merchant
    # # When I visit my bulk discounts index
    it 'has a link to delete each discount' do
      # # Then next to each bulk discount I see a link to delete it
      expect(page).to have_link("Delete Discount #{@discount1.id}")
      expect(page).to have_link("Delete Discount #{@discount2.id}")
    end
    
    it 'clicking the link deletes the discount' do
      # # When I click this link
      click_on "Delete Discount #{@discount1.id}"
      
      # # Then I am redirected back to the bulk discounts index page
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      visit current_path
      
      # # And I no longer see the discount listed
      expect(page).to_not have_content(@discount1.discount_percentage)
      # save_and_open_page #There was an error being thrown here but it's not consistent
      expect(page).to_not have_content(@discount1.quantity_threshold)
    end
  end
  
  describe 'user story 9 #api' do
    # # As a merchant
    # # When I visit the discounts index page
    it 'has a list of the upcoming holidays' do
      # # I see a section with a header of "Upcoming Holidays"
      expect(page).to have_content("Upcoming Holidays")
      # save_and_open_page
    
      # # In this section the name and date of the next 3 upcoming US holidays are listed.
      expect(page).to have_content("Presidents Day")
      expect(page).to have_content("2023-02-20")
      
      expect(page).to have_content("Good Friday")
      expect(page).to have_content("2023-04-07")
      
      expect(page).to have_content("Memorial Day")
      expect(page).to have_content("2023-05-29")
    end
  end
end