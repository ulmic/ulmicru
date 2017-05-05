class RemovePhotoFromBanners < ActiveRecord::Migration
  def change
    remove_column :banners, :photo, :string
  end
end
