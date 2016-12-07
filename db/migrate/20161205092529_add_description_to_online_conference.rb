class AddDescriptionToOnlineConference < ActiveRecord::Migration
  def change
    add_column :activity_lines_corporative_online_conferences, :event_id, :integer
  end
end
