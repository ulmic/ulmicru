class ReplaceSubscriptionColumn < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :receiver_type
    add_column :subscriptions, :receiver_type, :text
  end
end
