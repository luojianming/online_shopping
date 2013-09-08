class AddPopularToProduct < ActiveRecord::Migration
  def change
    add_column :products, :popular, :int
  end
end
