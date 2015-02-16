class Post < ActiveRecord::Base

  validates :tweet_id_str, presence: true, uniqueness: true
  validates :body, presence: true

  has_many :assigned_posts, dependent: :destroy
  has_many :orphans, through: :assigned_posts
  
  belongs_to :organization

  class << self
    def client_for(organization)
      # @@client ||=
      Twitter::REST::Client.new do |config|
        config.consumer_key        = organization.twitter_account.consumer_key #ENV['CONSUMER_KEY']
        config.consumer_secret     = organization.twitter_account.consumer_secret #ENV['CONSUMER_SECRET']
        config.access_token        = organization.twitter_account.access_token #ENV['ACCESS_TOKEN']
        config.access_token_secret = organization.twitter_account.access_token_secret #ENV['ACCESS_TOKEN_SECRET']
      end
    end

    def fetch_tweets_for(organization)
      #"ShelterOfLoveKH"
      client_for(organization).user_timeline(organization.twitter_account.username,since_id: (organization.posts.reorder{ id.asc }.first.try(:tweet_id_str) || 1) ).each do |tweet|

        photo_url = tweet.media? ? "#{tweet.media.first.media_url}:large" : nil
        shortened_url = tweet.media? ? tweet.media.first.url.to_s : nil
        
        post = organization.posts.create(
          tweet_id_str: tweet.id, 
          body: tweet.text.to_s.gsub(/#{shortened_url.to_s}/, '').squish,
          tweet_created_at: tweet.created_at,
          photo_url: photo_url
        )

        if post && tweet.hashtags?
          tweet.hashtags.each do |hashtag|
            hashtag_text = hashtag.text
            orphan = Orphan.where{|q| q.hashtag == hashtag_text }.first

            orphan.posts << post unless orphan.nil?

            post.body = post.body.gsub(/##{hashtag.text}/, '').squish
            post.save
            post.reload
            
          end
        end
        
      end
    end
  end
end
