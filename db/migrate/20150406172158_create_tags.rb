class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text :text
      t.text :tag_type
      t.references :record, polymorphic: true, index: true
      t.references :target, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
