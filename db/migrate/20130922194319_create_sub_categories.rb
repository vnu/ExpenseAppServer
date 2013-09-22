class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :display_name, null: false
      t.references :category, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
