class RemovePlaceFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :place, :string
  end
end
