class AddVersionToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :version, :integer
  end
end
