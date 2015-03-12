class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.text :title
      t.integer :member_id
      t.datetime :begin_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
