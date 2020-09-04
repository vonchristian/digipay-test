FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "#{SecureRandom.uuid}"}
    code            { Faker::Number.number(digits: 12) }

    factory :asset, class: 'Accounts::Asset' do
    end

    factory :liability, class: 'Accounts::Liability' do
    end

    factory :equity, class: 'Accounts::Equity' do
    end

    factory :revenue, class: 'Accounts::Revenue' do
    end

    factory :expense, class: 'Accounts::Expense' do
    end
  end
end
