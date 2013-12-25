class AddComfirmableToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :confirmation_token
    end
  end
end
