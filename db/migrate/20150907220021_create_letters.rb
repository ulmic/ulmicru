class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.text :subdivision_code
      t.integer :number
      t.datetime :send_date
      t.text :receiver
      t.text :title
      t.integer :list_number
      t.integer :annex
      t.integer :executor_id
      t.text :stamp_of_receipt
      t.text :note
      t.text :state
      t.text :executor_name

      t.timestamps null: false
    end
  end
end
