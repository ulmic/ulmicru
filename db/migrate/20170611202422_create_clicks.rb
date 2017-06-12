class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.text :url
      t.text :html_id
      t.text :page_url
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
