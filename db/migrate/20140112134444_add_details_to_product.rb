class AddDetailsToProduct < ActiveRecord::Migration
  def change
     add_column :products, :short_name, :string
     add_column :products, :label, :string
  end
end
