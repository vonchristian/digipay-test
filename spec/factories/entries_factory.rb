FactoryBot.define do
  factory :entry do
    description      { Faker::Company.bs }
    association      :commercial_document, factory: :customer
    entry_date       { Date.current }
    entry_time       { Time.zone.now }
    reference_number { 'test ref #' }

    factory :entry_with_credit_and_debit, :class => Entry do |entry_cd|
      entry_cd.after(:build) do |t|
        t.credit_amounts << FactoryBot.build(:credit_amount, :entry => t)
        t.debit_amounts << FactoryBot.build(:debit_amount, :entry => t)
      end
    end
  end
end
