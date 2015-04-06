class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text :text
      t.text :tag_type
      t.integer :record_id
      t.text :record_type
      t.integer :tag_target_id
      t.integer :tag_target_type

      t.timestamps null: false
    end
  end
end
