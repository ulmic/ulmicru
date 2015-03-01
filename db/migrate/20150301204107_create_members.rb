class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.text :patronymic
      t.integer :user_id
      t.text :motto
      t.integer :ticket_number
      t.integer :parent_id
      t.text :mobile_phone
      t.datetime :birth_date
      t.text :home_adress
      t.text :municipality
      t.text :locality
      t.text :avatar

      t.timestamps null: false
    end
  end
end
