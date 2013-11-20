class RemoveAttrsFromPruduct < ActiveRecord::Migration
  change_table :products do |t|
    t.remove :image, :color, :available
  end

end
