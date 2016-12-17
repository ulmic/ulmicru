class AddStateToOauthApps < ActiveRecord::Migration
  def change
    add_column :oauth_apps, :state, :text
  end
end
