class SubCategory < ActiveRecord::Base
  attr_accessible :category_id, :name, :sub_sub_categories_attributes
  belongs_to :category
  has_many :sub_sub_categories
  accepts_nested_attributes_for :sub_sub_categories, :reject_if => :all_blank, :allow_destroy => true
end
