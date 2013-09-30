class AddInitialBalToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :initial_bal, :decimal, precision: 10, scale: 2, :default => 0.0
  end
end
