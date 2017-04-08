class AddQuestionaryStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :questionary_state, :text, default: :not_existed
  end
end
