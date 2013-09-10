class RemoveTotalPriceFromOrder < ActiveRecord::Migration
  def up
    remove_column :orders, :total_price
  end

  def down
  end
end
