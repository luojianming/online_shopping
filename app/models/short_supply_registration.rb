class ShortSupplyRegistration < ActiveRecord::Base
  attr_accessible :addr, :brand, :description, 
                  :name, :size, :tel, :status

  validates :addr, :presence => true
  validates :tel, :presence => true
  validates :name, :presence => true
end
