class AddAuthorIdToNews < ActiveRecord::Migration
  def change
    add_column :news, :author_id, :number
  end
end
