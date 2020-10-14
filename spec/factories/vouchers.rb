FactoryBot.define do
  factory :voucher do
    reference_number { "MyString" }
    entry_date { "2020-09-21 20:05:09" }
    entry_time { "2020-09-21 20:05:09" }
    commercial_document { nil }
  end
end
