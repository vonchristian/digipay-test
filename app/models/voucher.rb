class Voucher < ApplicationRecord
  belongs_to :commercial_document, polymorphic: true
end
