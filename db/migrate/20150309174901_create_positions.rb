class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.text :title
      t.integer :member_id
      t.datetime :begin_date
      t.text :end_date, default: 'for_now'

      t.timestamps null: false
    end
  end
end
