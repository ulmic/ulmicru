class CreateProtocolAttenders < ActiveRecord::Migration
  def change
    create_table :protocol_attenders do |t|
      t.integer :member_id
      t.integer :protocol_id

      t.timestamps null: false
    end
  end
end
