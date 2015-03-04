class PostsFetchJob < ActiveJob::Base
  queue_as :default
  attr_accessor :organization

  def perform(organization)
    self.organization = organization
    
    Post.fetch_tweets_for(organization)
  end
  
  def after_perform(job)
    PostsFetchJob.set(wait: 10.minutes).perform_later(job.organization)
  end
end
