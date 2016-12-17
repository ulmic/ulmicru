class CreateOauthApps < ActiveRecord::Migration
  def change
    create_table :oauth_apps do |t|
      t.text :title
      t.text :client_id
      t.text :client_secret
      t.text :url

      t.timestamps null: false
    end
  end
end
