class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.float :price
      t.float :discount
      t.text :description
      t.text :image

      t.timestamps
    end
  end
end
