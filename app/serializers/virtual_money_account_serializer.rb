class VirtualMoneyAccountSerializer
  include JSONAPI::Serializer
  attributes :id, :balance, :account_number, :account_name
end