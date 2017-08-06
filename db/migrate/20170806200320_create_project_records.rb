class CreateProjectRecords < ActiveRecord::Migration
  def change
    create_table :project_records do |t|
      t.text :title
      t.integer :project_id
      t.integer :version
      t.text :record_type
      t.jsonb :properties

      t.timestamps null: false
    end
  end
end
