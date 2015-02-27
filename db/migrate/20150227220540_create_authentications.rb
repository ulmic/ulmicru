class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.text :provider
      t.text :uid
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
