class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.string :color
      t.integer :product_id

      t.timestamps
    end
  end
end
