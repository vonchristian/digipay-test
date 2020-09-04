class Agent < ApplicationRecord
  has_one :virtual_money_account, as: :depositor
  validates :account_name, presence: true, uniqueness: true

  def name
    account_name
  end
end
