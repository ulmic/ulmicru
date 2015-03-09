class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email
      t.text :password_digest
      t.text :first_name
      t.text :last_name
      t.text :patronymic
      t.integer :user_id
      t.text :motto
      t.integer :ticket
      t.integer :parent_id
      t.text :mobile_phone
      t.datetime :birth_date
      t.text :home_adress
      t.text :municipality
      t.text :locality
      t.text :avatar
      t.text :role
      t.text :state
      t.text :experience
      t.text :want_to_do
      t.string :type

      t.timestamps null: false
    end
  end
end
