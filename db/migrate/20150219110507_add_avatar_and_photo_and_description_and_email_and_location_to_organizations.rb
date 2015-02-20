class AddAvatarAndPhotoAndDescriptionAndEmailAndLocationToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :avatar, :string
    add_column :organizations, :photo, :string
    add_column :organizations, :description, :text
    add_column :organizations, :email, :string
    add_column :organizations, :location, :string
  end
end
