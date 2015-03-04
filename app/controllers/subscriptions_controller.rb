class SubscriptionsController < InheritedResources::Base
  skip_load_and_authorize_resource
  belongs_to :orphan
  
  def create
    @subscription = parent.subscriptions.build(post_params)
    @subscription.user = current_user || register_user
    
    if @subscription.valid?
      create!(notice: "Thank you for your support!") { parent_url }
    else
      flash[:error] = "Please try again"
      redirect_to parent_url
    end
  end
  
  def destroy
    destroy!(notice: "Sponsorship Cancelled") { edit_user_registration_url }
  end
  
  private
  
  def register_user
    user = nil
    email = params[:subscription][:account][:email]
    password = params.delete(:password)
    password_confirmation = params.delete(:password_confirmation)
    
    if password == password_confirmation
      user = User.new(email: email, password: password, password_confirmation: password_confirmation)
      user.save!
    end
    
    sign_in user
    
    user
  end

  def post_params
    params.require(:subscription).permit(:subscription_type, account: [:first_name, :last_name, :email, 
      billing_info: [:number, :month, :year],
      address: [:address1, :address2, :city, :state, :zip],
    ])
  end
end