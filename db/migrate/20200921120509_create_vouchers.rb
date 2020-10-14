class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers, id: :uuid do |t|
      t.string :reference_number
      t.datetime :entry_date
      t.time :entry_time
      t.belongs_to :entry,  foreign_key: true, type: :uuid
      t.references :commercial_document, polymorphic: true, null: false, type: :uuid,  index: { name: 'index_commercial_document_on_vouchers' }

      t.timestamps
    end
  end
end
