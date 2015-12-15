class CreateActivityLinesCorporativeArguments < ActiveRecord::Migration
  def change
    create_table :activity_lines_corporative_arguments do |t|
      t.integer :member_id
      t.text :text
      t.text :argument_type
      t.integer :confession_id

      t.timestamps null: false
    end
  end
end
