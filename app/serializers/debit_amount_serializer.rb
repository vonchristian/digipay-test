class DebitAmountSerializer
  include JSONAPI::Serializer
  set_id :id
  set_type :debit_amount

  attributes :amount_cents, :account_name
end
