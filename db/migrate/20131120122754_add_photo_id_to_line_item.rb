class AddPhotoIdToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :photo_id, :integer
  end
end
