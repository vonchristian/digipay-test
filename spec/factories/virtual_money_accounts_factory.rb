FactoryBot.define do
  factory :virtual_money_account do
    association :depositor, factory: :customer
    association :liability_account, factory: :liability
    account_number { SecureRandom.uuid }
  end
end