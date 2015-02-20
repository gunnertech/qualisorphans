class Organization < ActiveRecord::Base
  resourcify
  
  has_many :orphans
  has_many :posts
  
  has_one :twitter_account
  
  mount_uploader :avatar, AvatarUploader
  mount_uploader :photo, PhotoUploader
  
  attr_accessor :email_to_add
  
  def to_s
    name
  end
  
  def users
    User.where{ id == 0 }
  end
  
end
