class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :orphan
  
  before_create :create_recurly_subscription
  after_create :send_thankyou_email
  
  attr_accessor :account, :subscription_type
  
  validates :user_id, presence: true
  
  def create_recurly_subscription
    subscription = Recurly::Subscription.create(
      :plan_code => (subscription_type == "maximum" ? orphan.maximum_plan_id : (subscription_type == "medium" ? orphan.medium_plan_id : orphan.plan_id)),
      :currency  => 'USD',
      :customer_notes  => 'Thank you for your support!',
      account: user.find_or_create_account(account)
    )
    self.uuid = subscription.uuid
  end
  
  def send_thankyou_email
    SubscriptionMailer.confirmation_email(user,orphan).deliver_later
  end
end
