class CreateFunctionalYofications < ActiveRecord::Migration
  def change
    create_table :functional_yofications do |t|
      t.text :body
      t.text :yoficated_body
      t.integer :user_id
      t.text :status

      t.timestamps null: false
    end
  end
end
