class OrphansController < InheritedResources::Base
  
  before_filter :set_organization_id, only: :create
  
  private

  def orphan_params
    params.require(:orphan).permit(:first_name, :last_name, :hashtag, :photo, :avatar, :description, :organization_id)
  end
  
  def begin_of_association_chain
    @organization
  end
  
  def set_organization_id
    params[:orphan][:organization_id] = @organization.id
  end
end

