class CreateProtocols < ActiveRecord::Migration
  def change
    create_table :protocols do |t|
      t.text :title
      t.integer :team_id
      t.integer :document_id
      t.text :scan
      t.text :state

      t.timestamps null: false
    end
  end
end
