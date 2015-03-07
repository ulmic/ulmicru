class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.datetime :published_at
      t.text :photo
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
