class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
  
  #return all items from a specific merchant on an invoice
  def merchant_items(merchant)
    invoice_items.joins(:item)
                 .where('items.merchant_id = ?', merchant.id)
  end
  
  #return total revenue for one merchant on an invoice
  def merchant_total_revenue(merchant)
    invoice_items.joins(:item)
                 .where('items.merchant_id = ?', merchant.id)
                 .sum('quantity * invoice_items.unit_price')
  end
  
  def merchant_discounted_revenue(merchant)
    merchant_items(merchant).sum do |items|
      items.discount_unit_price
    end
  end

  def discounted_revenue
    invoice_items.sum do |item|
      item.discount_unit_price
    end
  end
  
end