class AddCredentialToAgent < ActiveRecord::Migration[6.0]
  def change
    add_reference :agents, :credential, null: false, foreign_key: true, type: :uuid
  end
end
