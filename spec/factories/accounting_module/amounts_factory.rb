FactoryBot.define do
  factory :amount, class: AccountingModule::Amount do
    amount { 100 }
    association :account
    association :entry
    factory :debit_amount, class: AccountingModule::Amounts::DebitAmount do

    end

    factory :credit_amount, class: AccountingModule::Amounts::CreditAmount do

    end
  end
end
