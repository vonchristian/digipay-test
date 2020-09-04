class CreateVirtualMoneyAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :virtual_money_accounts, id: :uuid do |t|
      t.references :depositor, polymorphic: true, null: false, type: :uuid
      t.string     :account_number
      t.belongs_to :liability_account, null: false, foreign_key: { to_table: :accounts }, type: :uuid

      t.timestamps
    end
    add_index :virtual_money_accounts, :account_number, unique: true
  end
end
