class CreateSharedTransactions < ActiveRecord::Migration
  def change
    create_table :shared_transactions do |t|
      t.references :vendor, null: false
      t.references :transaction, null: false
      t.text :notes
      t.integer :owner_id, references: :users, null: false
      t.datetime :transaction_date
      t.decimal :amount, precision: 10, scale: 2
      t.references :user, null: false
      t.string :status, default: 'open'

      t.timestamps
    end
  end
end
