class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :price, :product_id, :quantity

  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def total_price
    product.price * quantity
  end
end
