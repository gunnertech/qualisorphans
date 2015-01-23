class PostsController < InheritedResources::Base

  private

    def post_params
      params.require(:post).permit(:tweet_id_str, :body, :photo_url, :tweet_created_at)
    end
end

