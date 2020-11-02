FactoryBot.define do
  factory :wallet do
    virtual_money_account { nil }
    account_owner { nil }
  end
end
