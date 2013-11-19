class CreateSubSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_sub_categories do |t|
      t.string :name
      t.integer :sub_category_id

      t.timestamps
    end
  end
end
