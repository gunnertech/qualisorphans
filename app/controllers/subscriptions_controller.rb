class SubscriptionsController < InheritedResources::Base
  belongs_to :orphan
  
  def create
    @subscription = parent.subscriptions.build
    @subscription.user = current_user
    
    create!
  end
  
  private

    def post_params
      params.require(:subscription).permit(:tweet_id_str, :body, :photo_url, :tweet_created_at)
    end
end