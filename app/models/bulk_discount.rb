class BulkDiscount < ApplicationRecord
  validates :discount_percentage, numericality: { only_integer: true, greater_than: 0 }, presence: true
  validates :quantity_threshold, numericality: { only_integer: true }, presence: true
  
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
end