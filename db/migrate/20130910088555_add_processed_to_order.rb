class AddProcessedToOrder < ActiveRecord::Migration
  def change
    change_column :orders, :processed, :integer, :default => 0
  end
end
