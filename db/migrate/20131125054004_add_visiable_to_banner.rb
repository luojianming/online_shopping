class AddVisiableToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :visiable, :integer
  end
end
