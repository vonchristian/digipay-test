class Wallet < ApplicationRecord
  belongs_to :virtual_money_account
  belongs_to :account_owner
end
