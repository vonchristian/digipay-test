class Agent < ApplicationRecord
  has_one :wallet, as: :account_owner

  validates :account_name, presence: true, uniqueness: true

  def name
    account_name
  end
end
