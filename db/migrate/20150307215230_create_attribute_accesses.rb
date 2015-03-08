class CreateAttributeAccesses < ActiveRecord::Migration
  def change
    create_table :attribute_accesses do |t|
      t.integer :member_id
      t.text :member_attribute
      t.text :access

      t.timestamps null: false
    end
  end
end
