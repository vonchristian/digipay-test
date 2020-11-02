class AddOriginationToVouchers < ActiveRecord::Migration[6.0]
  def change
    add_reference :vouchers, :origination, polymorphic: true, null: false, type: :uuid
  end
end
