module AccountingModule
  class VoucherAmount < ApplicationRecord
    belongs_to :voucher
    belongs_to :account, class_name: "AccountingModule::Account"
  end
end
