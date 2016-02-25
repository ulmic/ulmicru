class CreateDeliveryCampaigns < ActiveRecord::Migration
  def change
    create_table :delivery_campaigns do |t|
      t.text :title
      t.text :body
      t.text :image
      t.text :link
      t.integer :creator_id
      t.datetime :mailing_date

      t.timestamps null: false
    end
  end
end
