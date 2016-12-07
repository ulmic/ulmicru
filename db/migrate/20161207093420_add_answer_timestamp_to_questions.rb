class AddAnswerTimestampToQuestions < ActiveRecord::Migration
  def change
    add_column :activity_lines_corporative_online_conference_questions, :answer_timestamp, :text
  end
end
