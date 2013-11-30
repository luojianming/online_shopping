class CreateConstantTexts < ActiveRecord::Migration
  def change
    create_table :constant_texts do |t|
      t.text :contact_state
      t.text :pay_state
      t.text :store_intro
      t.text :who_we_are
      t.text :how_to_buy
      t.text :delivery_area
      t.text :privacy_state
      t.text :changes_state
      t.text :cookies_state
      t.text :welcome_state

      t.timestamps
    end
  end
end
