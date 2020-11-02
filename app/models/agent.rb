class Agent < ApplicationRecord
  has_one    :wallet, as: :account_owner
  belongs_to :credential
  has_many   :vouchers, class_name: "AccountingModule::Voucher", as: :origination
  validates  :account_name, presence: true, uniqueness: true

  def name
    account_name
  end
end
