class OrganizationsController < InheritedResources::Base
  
  skip_before_filter :set_organization, only: [:new, :create]
  
  def show
    redirect_to root_url
  end
  
  def update
    if params[:organization][:email_to_add].present?
      if user = User.find_by_email(params[:organization][:email_to_add])
        user.add_role("admin",resource)
        update!(notice: "User Added!"){ organization_users_url(resource) }
      else
        update! do |format|
          flash[:error] = "No user matches that email"
          format.html { redirect_to organization_users_url(resource) }
        end
      end
      
    else
      update!
    end
  end

  private

    def organization_params
      params.require(:organization).permit(:domain, :name, :url, :email, :location, :description, :avatar, :photo, :email_to_add, :recurly_subdomain, :recurly_api_key, :recurly_default_currency)
    end
end

