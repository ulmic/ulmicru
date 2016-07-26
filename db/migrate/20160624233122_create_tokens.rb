class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.text :content
      t.integer :record_id
      t.text :record_type

      t.timestamps null: false
    end
  end
end
