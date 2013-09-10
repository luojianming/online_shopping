class AddProcessedToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :processed, :integer, :default => 0
  end
end
