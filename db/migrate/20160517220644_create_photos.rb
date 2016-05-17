class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :image
      t.datetime :date
      t.integer :author_id
      t.text :author_name
      t.text :slug

      t.timestamps null: false
    end
  end
end
