class ConstantText < ActiveRecord::Base
  attr_accessible :changes_state, :contact_state, :cookies_state, :delivery_area, :how_to_buy, :pay_state, :privacy_state, :store_intro, :welcome_state, :who_we_are
end
