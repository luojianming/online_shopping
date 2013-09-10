class ChangePriceToDecimal < ActiveRecord::Migration
  def up
    change_column :products, :price, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end

  def down
  end
end

