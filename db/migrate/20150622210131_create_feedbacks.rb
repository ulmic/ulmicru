class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.text :url
      t.text :text
      t.text :state

      t.timestamps null: false
    end
  end
end
