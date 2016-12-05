class CreateActivityLinesCorporativeOnlineConferenceQuestions < ActiveRecord::Migration
  def change
    create_table :activity_lines_corporative_online_conference_questions do |t|
      t.text :text
      t.integer :user_id
      t.integer :online_conference_id
      t.text :state

      t.timestamps null: false
    end
  end
end
