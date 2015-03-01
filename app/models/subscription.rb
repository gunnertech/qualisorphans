class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :orphan
  
  before_create :create_recurly_subscription
  
  attr_accessor :account, :subscription_type
  
  def create_recurly_subscription
    subscription = Recurly::Subscription.create(
      :plan_code => (subscription_type == "full" ? orphan.full_plan_id : orphan.plan_id),
      :currency  => 'USD',
      :customer_notes  => 'Thank you for your support!',
      account: user.find_or_create_account(account)
    )
    self.uuid = subscription.uuid
  end
end
