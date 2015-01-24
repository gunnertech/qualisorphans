class AddAvatarAndPhotoToOrphans < ActiveRecord::Migration
  def change
    add_column :orphans, :avatar, :string
    add_column :orphans, :photo, :string
  end
end
