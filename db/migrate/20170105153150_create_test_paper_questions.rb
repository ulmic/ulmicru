class CreateTestPaperQuestions < ActiveRecord::Migration
  def change
    create_table :test_paper_questions do |t|
      t.text :text
      t.integer :test_paper_id
      t.text :question_type
      t.text :state

      t.timestamps null: false
    end
  end
end
