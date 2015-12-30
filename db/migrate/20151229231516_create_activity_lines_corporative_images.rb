class CreateActivityLinesCorporativeImages < ActiveRecord::Migration
  def change
    create_table :activity_lines_corporative_images do |t|
      t.integer :confession_id
      t.integer :member_id
      t.text :file

      t.timestamps null: false
    end
  end
end
