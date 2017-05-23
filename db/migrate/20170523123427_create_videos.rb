class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :link
      t.text :title
      t.text :state

      t.timestamps null: false
    end
  end
end
