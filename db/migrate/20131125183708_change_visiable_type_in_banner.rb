class ChangeVisiableTypeInBanner < ActiveRecord::Migration
  def up
    change_column :banners, :visiable, :string
  end


  def down
  end
end
