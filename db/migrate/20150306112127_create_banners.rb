class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :photo
      t.string :link
      t.datetime :begin_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
