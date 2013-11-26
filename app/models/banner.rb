class Banner < ActiveRecord::Base
  attr_accessible :image, :visiable
  mount_uploader :image, ImageUploader
end
