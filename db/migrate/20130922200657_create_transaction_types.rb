class CreateTransactionTypes < ActiveRecord::Migration
  def change
    create_table :transaction_types do |t|
      t.string :display_name, null: false
      t.timestamps
    end
  end
end
