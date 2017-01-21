class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.text :title
      t.text :description
      t.text :foursquare_uid
      t.text :latitude
      t.text :longitude

      t.timestamps null: false
    end
  end
end
