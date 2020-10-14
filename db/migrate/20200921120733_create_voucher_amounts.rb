class CreateVoucherAmounts < ActiveRecord::Migration[6.0]
  def change
    create_table :voucher_amounts, id: :uuid do |t|
      t.string :type
      t.belongs_to :account, null: false, foreign_key: true
      t.monetize :amount, limit: 12, default: 0, null: false

      t.timestamps
    end

    add_index :voucher_amounts, :type
  end
end
