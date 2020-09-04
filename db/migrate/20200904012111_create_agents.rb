class CreateAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :agents, id: :uuid do |t|
      t.string :account_name

      t.timestamps
    end
  end
end
