class CreateProtocolAbsents < ActiveRecord::Migration
  def change
    create_table :protocol_absents do |t|
      t.integer :member_id
      t.integer :protocol_id

      t.timestamps null: false
    end
  end
end
