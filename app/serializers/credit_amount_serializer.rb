class CreditAmountSerializer
  include JSONAPI::Serializer
  set_id :id
  set_type :debit_amount

  attributes :account_name, :amount
end
