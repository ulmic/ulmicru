class RemoveNewsRatingsTable < ActiveRecord::Migration
  def change
    drop_table :news_ratings
  end
end
