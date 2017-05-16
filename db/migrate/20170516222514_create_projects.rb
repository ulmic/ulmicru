class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :title
      t.text :url
      t.text :project_type
      t.json :properties
      t.text :view
      t.text :state

      t.timestamps null: false
    end
  end
end
