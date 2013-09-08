class AddAvailableToProduct < ActiveRecord::Migration
  def change
    add_column :products, :available, :int
  end
end
