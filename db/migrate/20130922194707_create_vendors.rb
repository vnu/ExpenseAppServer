class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :display_name, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
