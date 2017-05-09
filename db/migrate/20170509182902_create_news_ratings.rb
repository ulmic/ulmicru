class CreateNewsRatings < ActiveRecord::Migration
  def change
    create_table :news_ratings do |t|
      t.integer :news_id
      t.integer :rating
      t.integer :views_count
      t.integer :round

      t.timestamps null: false
    end
  end
end
