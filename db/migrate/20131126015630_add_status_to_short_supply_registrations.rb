class AddStatusToShortSupplyRegistrations < ActiveRecord::Migration
  def change
    add_column :short_supply_registrations, :status, :string
  end
end
