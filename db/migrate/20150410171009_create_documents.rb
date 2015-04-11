class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :file
      t.text :title

      t.timestamps null: false
    end
  end
end
