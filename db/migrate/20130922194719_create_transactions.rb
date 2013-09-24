class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :vendor, null: false
      t.references :account, null: false
      t.references :category, null: false
      t.references :sub_category
      t.references :payment_mode, null: false
      t.text :notes
      t.references :transaction_type, null: false
      t.decimal :amount, precision: 10, scale: 2
      t.references :user, null: false
      t.timestamps
    end
  end
end
