class AddPhotoToNews < ActiveRecord::Migration
  def change
    add_column :news, :photo, :text
  end
end
