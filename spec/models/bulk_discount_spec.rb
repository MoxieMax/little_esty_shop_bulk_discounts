require 'rails_helper'

describe BulkDiscount do
  describe "validations" do
    it { should validate_presence_of :discount_percentage}
    it { should validate_presence_of :quantity_threshold}
    it { should validate_numericality_of :discount_percentage}
    it { should validate_numericality_of :quantity_threshold}
  end
  
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end
end