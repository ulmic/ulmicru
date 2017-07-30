class CreateProjectRecords < ActiveRecord::Migration
  def change
    create_table :project_records do |t|
      t.integer :project_id
      t.text :title
      t.text :record_type
      t.jsonb :properties

      t.timestamps null: false
    end
  end
end
