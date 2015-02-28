class PostsController < InheritedResources::Base

  private

    def post_params
      params.require(:post).permit(:tweet_id_str, :body, :photo_url, :tweet_created_at)
    end
    
    def begin_of_association_chain
      @organization
    end
    
    def collection
      @posts = end_of_association_chain
      
      @posts = @posts.reorder{ id.desc }
    end
end

