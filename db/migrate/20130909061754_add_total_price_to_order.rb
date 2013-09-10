class AddTotalPriceToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total_price, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end
end
