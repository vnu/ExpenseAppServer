class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :twitter_user_name, null: false
      t.string :twitter_uid, null: false

      t.timestamps
    end
  end
end
