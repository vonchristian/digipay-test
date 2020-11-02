FactoryBot.define do
  factory :account, class: AccountingModule::Account do
    sequence(:name) { |n| "#{SecureRandom.uuid}"}
    code            { Faker::Number.number(digits: 12) }

    factory :asset, class: AccountingModule::Accounts::Asset do
    end

    factory :liability, class: AccountingModule::Accounts::Liability do
    end

    factory :equity, class: AccountingModule::Accounts::Equity do
    end

    factory :revenue, class: AccountingModule::Accounts::Revenue do
    end

    factory :expense, class: AccountingModule::Accounts::Expense do
    end
  end
end
