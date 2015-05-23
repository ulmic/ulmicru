class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :title
      t.text :view
      t.text :size
      t.text :text
      t.text :slug

      t.timestamps null: false
    end
  end
end
