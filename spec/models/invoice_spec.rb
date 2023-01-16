require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end
  describe "instance methods" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item2 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 10, status: 1)
    end
    
    it "total_revenue" do
      expect(@invoice1.total_revenue).to eq(100)
    end
    
    describe 'user story 6, ' do
      before :each do
        @merchant2 = Merchant.create!(name: 'Hair-y Care-y')
        
        @item3 = Item.create!(name: "Dry Shampoo", description: "This degreases your hair", unit_price: 10, merchant_id: @merchant2.id, status: 1)
        @item4 = Item.create!(name: "Superior Butterfly Clip", description: "This holds up your hair but in a better clip", unit_price: 5, merchant_id: @merchant2.id)
        
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item3.id, quantity: 10, unit_price: 10, status: 2)
        @ii_4 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item4.id, quantity: 10, unit_price: 10, status: 1)
        
        @discount1 = BulkDiscount.create!(discount_percentage: 10, quantity_threshold: 15, merchant_id: @merchant1.id)
        @discount2 = BulkDiscount.create!(discount_percentage: 10, quantity_threshold: 10, merchant_id: @merchant2.id)
      end
      
      it 'returns merchant_items' do
        # # As a merchant
        # # When I visit my merchant invoice show page
        # # Then I see the total revenue for my merchant from this invoice (not including discounts)
          # # -implied task: separate out the merchant's items from an invoice 
        # # And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation
        expect(@invoice1.merchant_items(@merchant1)).to eq([@ii_1, @ii_2])#specific items from the invoice
        expect(@invoice1.merchant_items(@merchant2)).to eq([@ii_3, @ii_4])#specific items from the invoice
        
      end
      
      it 'returns merchant total revenue' do
        expect(@invoice1.total_revenue).to eq(300)
        
        expect(@invoice1.merchant_total_revenue(@merchant1)).to eq(100)
        expect(@invoice1.merchant_total_revenue(@merchant2)).to eq(200)
      end
      
      xit 'returns the merchant total revenue after discounts' do
        expect(@invoice1.discounted_revenue).to eq(190)
        
        expect(@invoice1.merchant_discounted_revenue(@merchant1)).to eq(100)
        expect(@invoice1.merchant_discounted_revenue(@merchant2)).to eq(90)
      end
    end
  end
end
