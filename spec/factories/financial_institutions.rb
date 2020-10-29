FactoryBot.define do
  factory :financial_institution do
    name { Faker::Company.name }
    category { "MyString" }
  end
end
