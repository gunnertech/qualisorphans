class SubscriptionsController < InheritedResources::Base
  belongs_to :orphan
  
  def create
    @subscription = parent.subscriptions.build(post_params)
    @subscription.user = User.first#current_user
    
    create!(notice: "Thank you for your support!") { parent_url }
  end
  
  def destroy
    destroy!(notice: "Sponsorship Cancelled") { edit_user_registration_url }
  end
  
  private

  def post_params
    params.require(:subscription).permit(account: [:first_name, :last_name, :email, 
      billing_info: [:number, :month, :year],
      address: [:address1, :address2, :city, :state, :zip],
    ])
  end
end