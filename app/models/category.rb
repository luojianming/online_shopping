class Category < ActiveRecord::Base
  attr_accessible :name, :sub_categories_attributes, :sub_sub_categories_attributes
  has_many :sub_categories

  accepts_nested_attributes_for :sub_categories, :reject_if => :all_blank,
                                :allow_destroy => true
end
