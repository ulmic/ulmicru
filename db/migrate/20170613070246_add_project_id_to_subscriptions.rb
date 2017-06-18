class AddProjectIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :project_id, :integer
  end
end
