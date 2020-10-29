class CreateFinancialInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_institutions, id: :uuid do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
    add_index :financial_institutions, :category
  end
end
