class CreatePaymentModes < ActiveRecord::Migration
  def change
    create_table :payment_modes do |t|
      t.string :display_name, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
