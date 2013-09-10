class ChangeColumnsAttrInProduct < ActiveRecord::Migration
  def up
    change_column :products, :name, :string
    change_column :products, :image, :string
  end

  def down
  end
end
