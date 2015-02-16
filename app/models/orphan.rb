class Orphan < ActiveRecord::Base

  has_many :assigned_posts, dependent: :destroy
  has_many :posts, through: :assigned_posts
  
  has_many :subscriptions
  has_many :users, through: :subscriptions
  
  belongs_to :organization

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :hashtag, presence: true, uniqueness: true

  mount_uploader :avatar, AvatarUploader
  mount_uploader :photo, PhotoUploader

  def to_s
    "#{first_name} #{last_name}"
  end

end
