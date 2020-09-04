class EntrySerializer
  include JSONAPI::Serializer
  set_id :id
  attributes :id, :reference_number, :description, :entry_date, :entry_time, :debit_amounts, :credit_amounts
end
