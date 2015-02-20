class UsersController < InheritedResources::Base
  belongs_to :organiztion, optional: true
  private
    
  def collection
    # return @alerts if @alerts

    user_ids =  User.with_any_role :fake,{ name: "admin", resource: @organization }
  	@users = end_of_association_chain
    
    @users = @users.where{ id >> my{user_ids} }
  end
end

