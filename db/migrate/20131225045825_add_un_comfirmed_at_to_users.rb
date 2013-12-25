class AddUnComfirmedAtToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
       t.datetime :confirmed_at
       t.datetime :confirmation_sent_at
    end
  end
end
