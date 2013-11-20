class Photo < ActiveRecord::Base
  attr_accessible :color, :image, :product_id
  mount_uploader :image, ImageUploader
  belongs_to :product
end
