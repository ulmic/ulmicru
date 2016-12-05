class CreateActivityLinesCorporativeOnlineConferences < ActiveRecord::Migration
  def change
    create_table :activity_lines_corporative_online_conferences do |t|
      t.text :title
      t.datetime :date
      t.text :video_link
      t.text :state

      t.timestamps null: false
    end
  end
end
