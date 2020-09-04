class Customer < ApplicationRecord
  has_one :virtual_money_account, as: :depositor

  validates :first_name, :last_name, presence: true
  def name
    "#{first_name} #{last_name}"
  end
end
