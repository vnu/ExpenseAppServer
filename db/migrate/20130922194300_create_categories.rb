class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :display_name, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
