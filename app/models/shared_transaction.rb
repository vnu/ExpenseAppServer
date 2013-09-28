# == Schema Information
#
# Table name: shared_transactions
#
#  id               :integer          not null, primary key
#  vendor_id        :integer          not null
#  transaction_id   :integer          not null
#  notes            :text
#  owner_id         :integer          not null
#  transaction_date :datetime
#  amount           :decimal(10, 2)
#  user_id          :integer          not null
#  status           :string(255)      default("open")
#  created_at       :datetime
#  updated_at       :datetime
#

class SharedTransaction < ActiveRecord::Base
  belongs_to :transaction
  belongs_to :vendor
  belongs_to :user
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id'

  COLUMNS = ["id", "transaction_id", "amount", "vendor", "payee","payer","owes", "status"]

  def self.to_jsonFormat(transactions, user_id)
    new_trans = []
    transactions.each do |t|
      unless t.user_id == t.owner_id
        owe = nil
        owes = nil
        exp = nil
        if t.owner_id != user_id
          payer = t.user.name.titleize
          payee = "You"
          exp = true
          
        else
          exp = false
          payer = "You"
          payee = t.user.name.titleize
          owes = "#{t.user.name} owes you"
          
        end
        owes = "#{payee} owe #{payer}"
        json_t = {
            id: t.id,
            transaction_id: t.transaction_id,
            amount: t.amount,
            vendor: t.vendor.display_name,
            payer: payer,
            payee: payee,
            owes: owes,
            status: t.status,
            type: exp
          }
        new_trans << json_t
      end
    end
    new_trans
  end
end
