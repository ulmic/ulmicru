class AddMoreFieldsToQuestionary < ActiveRecord::Migration
  def change
    add_column :users, :source_to_know, :text
  end
end
