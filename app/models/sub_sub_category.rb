class SubSubCategory < ActiveRecord::Base
  attr_accessible :name, :sub_category_id
  belongs_to :sub_category
  has_many :products
end
