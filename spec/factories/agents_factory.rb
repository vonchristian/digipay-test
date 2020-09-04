FactoryBot.define do
  factory :agent do
    account_name { Faker::Company.name }
  end
end