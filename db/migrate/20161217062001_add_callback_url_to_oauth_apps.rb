class AddCallbackUrlToOauthApps < ActiveRecord::Migration
  def change
    add_column :oauth_apps, :callback_url, :text
  end
end
