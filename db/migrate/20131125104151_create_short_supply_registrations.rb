class CreateShortSupplyRegistrations < ActiveRecord::Migration
  def change
    create_table :short_supply_registrations do |t|
      t.string :name
      t.string :size
      t.string :brand
      t.string :description
      t.string :tel
      t.string :addr

      t.timestamps
    end
  end
end
