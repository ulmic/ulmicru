class AddFileToLetter < ActiveRecord::Migration
  def change
    add_column :letters, :file, :text
  end
end
