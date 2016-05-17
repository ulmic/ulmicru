class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :file
      t.datetime :date
      t.integer :author_id
      t.text :author_name
      t.text :slug
      t.text :image_type
      t.text :state

      t.timestamps null: false
    end
  end
end
