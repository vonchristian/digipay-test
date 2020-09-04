class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries, id: :uuid do |t|
      t.string :reference_number
      t.datetime :entry_date
      t.time :entry_time
      t.references :commercial_document, polymorphic: true, null: false, index: { name: 'index_commercial_document_on_entries' }
      t.string :description

      t.timestamps
    end
  end
end
