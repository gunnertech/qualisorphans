class TwitterAccountsController < InheritedResources::Base
  defaults :singleton => true
  belongs_to :organization
  
  def create
    create!(notice: "Changes Made") { root_url }
  end
  
  def update
    update!(notice: "Changes Made") { root_url }
  end

  private

    def twitter_account_params
      params.require(:twitter_account).permit(:username, :consumer_key, :consumer_secret, :access_token, :access_token_secret)
    end
end

