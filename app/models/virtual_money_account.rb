class VirtualMoneyAccount < ApplicationRecord
  belongs_to :depositor, polymorphic: true
  belongs_to :liability_account, class_name: 'Accounts::Liability'

  validates :account_number, presence: true, uniqueness: true
  def balance(args={})
    liability_account.balance(args)
  end
  def account_name
    depositor.name
  end
end
