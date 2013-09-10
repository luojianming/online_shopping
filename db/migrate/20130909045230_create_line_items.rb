class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :cart_id
      t.integer :quantity, :default => 1
      t.decimal :price, :precision => 8, :scale => 2, :defalut => 0.0

      t.timestamps
    end
  end
end
