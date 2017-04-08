class AddMoreFieldsToQuestionary < ActiveRecord::Migration
  def change
    add_column :users, :source, :text
  end
end
