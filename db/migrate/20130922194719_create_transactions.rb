class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :vendor, null: false
      t.references :account, null: false
      t.text :notes
      t.datetime :transaction_date
      t.references :transaction_type, null: false
      t.decimal :amount, precision: 10, scale: 2
      t.references :user, null: false
      t.timestamps
    end
  end
end
