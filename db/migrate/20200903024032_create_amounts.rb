class CreateAmounts < ActiveRecord::Migration[6.0]
  def change
    create_table :amounts, id: :uuid do |t|
      t.belongs_to :account, foreign_key: true, type: :uuid
      t.belongs_to :entry, foreign_key: true, type: :uuid
      t.monetize :amount, limit: 12, default: 0, null: false
      t.string :type

      t.timestamps
    end
    add_index :amounts, :type
    add_index :amounts, [:account_id, :entry_id]
    add_index :amounts, [:entry_id, :account_id]
  end
end
