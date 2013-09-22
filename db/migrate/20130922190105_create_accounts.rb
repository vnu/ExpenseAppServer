class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :display_name
      t.decimal :balance, precision: 10, scale: 2, default: 0.0
      t.references :user

      t.timestamps
    end
  end
end
