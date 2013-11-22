class ChangeCategoryInProduct < ActiveRecord::Migration
  def up
    remove_column :products, :category
    add_column :products, :sub_sub_category_id, :integer
  end

  def down
  end
end
