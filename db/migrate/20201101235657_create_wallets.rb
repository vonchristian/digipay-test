class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets, id: :uuid do |t|
      t.string :name, null: false
      t.belongs_to :virtual_money_account, null: false, foreign_key: true, type: :uuid
      t.references :account_owner, polymorhic: true, null: false,  type: :uuid
      t.string :account_number, null: false

      t.timestamps
    end
  end
end
