class CreateTestPapers < ActiveRecord::Migration
  def change
    create_table :test_papers do |t|
      t.text :title
      t.datetime :begin_date
      t.datetime :end_date
      t.integer :record_id
      t.text :record_type
      t.text :state

      t.timestamps null: false
    end
  end
end
