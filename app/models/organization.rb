class Organization < ActiveRecord::Base
  has_many :orphans
  has_many :posts
  
  has_one :twitter_account
  
  def to_s
    name
  end
  
end
