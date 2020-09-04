FactoryBot.define do
  factory :amount do
    amount { 100 }
    association :account
    association :entry
    factory :debit_amount, class: Amounts::DebitAmount do
      type { 'Amounts::DebitAmount' }
    end

    factory :credit_amount, class: Amounts::CreditAmount do
      type { 'Amounts::CreditAmount' }
    end
  end
end
