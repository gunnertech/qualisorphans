class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :orphan
  
  has_one :organization, through: :orphan
  
  before_create :create_recurly_subscription
  after_create :send_thankyou_email
  
  attr_accessor :account, :subscription_type
  
  validates :user_id, presence: true
  
  def create_recurly_subscription
    Recurly.subdomain = organization.recurly_subdomain || ENV['RECURLY_SUBDOMAIN']
    Recurly.api_key = organization.recurly_api_key || ENV['RECURLY_API_KEY']
    Recurly.default_currency = organization.recurly_default_currency || 'USD'
    
    subscription = Recurly::Subscription.create(
      plan_code: (subscription_type == "maximum" ? orphan.maximum_plan_id : (subscription_type == "medium" ? orphan.medium_plan_id : orphan.plan_id)),
      currency: 'USD',
      :customer_notes: 'Thank you for your support!',
      account: user.find_or_create_account(account,organization)
    )
    self.uuid = subscription.uuid
  end
  
  def send_thankyou_email
    SubscriptionMailer.confirmation_email(user,orphan).deliver_later
  end
end
