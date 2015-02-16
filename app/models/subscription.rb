class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :orphan
  
  before_create :create_recurly_subscription
  
  def create_recurly_subscription
    subscription = Recurly::Subscription.create(
      :plan_code => 'child',
      :currency  => 'US',
      :customer_notes  => 'Thank you for your support!',
      :account   => {
        :account_code => user.account.account_code,
        :email        => user.account.email,
        :first_name   => user.account.first_name,
        :last_name    => user.account.last_name,
        :billing_info => {
          :number => "#{user.account.billing_info.first_six}#{user.account.billing_info.last_four}",
          :month  => user.account.billing_info.month,
          :year   => user.account.billing_info.year,
        }
      }
    )
  end
end
