class AddRequestDateToQuestionaries < ActiveRecord::Migration
  def change
    add_column :users, :request_date, :datetime
  end
end
