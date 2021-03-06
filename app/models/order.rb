class Order < ActiveRecord::Base
  attr_accessible :address, :name, :tel, :processed
  validates :name, :address, :tel, :presence => true

  has_many :line_items, :dependent => :destroy

  define_index do
    indexes :name
    indexes :tel
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def process
    line_items.each do |item|
      product = Product.find(item.product_id)
      if product.stock
        product.stock = product.stock - item.quantity
      end
      product.save
    end
  end
end
