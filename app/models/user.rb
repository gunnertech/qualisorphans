class User < ActiveRecord::Base
  rolify after_add: :touch_self, after_remove: :touch_self
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  has_many :subscriptions
  has_many :orphans, through: :subscriptions
  
  def account(organization)
    Recurly.subdomain = organization.recurly_subdomain || ENV['RECURLY_SUBDOMAIN']
    Recurly.api_key = organization.recurly_api_key || ENV['RECURLY_API_KEY']
    Recurly.default_currency = organization.recurly_default_currency || 'USD'
    @account ||= Recurly::Account.find(account_id(organization)) rescue nil
  end
  
  def account_id(organization)
    "recurly_#{organization.id}_#{id.to_s}"
  end
  
  def subscription_for(orphan)
    subscriptions.where{ orphan_id == my{ orphan.id }}.first
  end
  
  def is_sponsoring?(orphan)
    orphans.include?(orphan)
  end
  
  def find_or_create_account(params,organization)
    params[:account_code] = account_id(organization)
    params[:billing_info] ||= {}
    params[:address] ||= {}
    params[:address][:country] = "US"
    
    [:first_name, :last_name].each do |key|
      params[:billing_info][key] = params[key]
    end
    
    params[:address].each do |key, value|
      params[:billing_info][key] = value
    end
    
    account(organization) || create_account(params)
  end
  
  def create_account(params)
    Recurly.subdomain = organization.recurly_subdomain || ENV['RECURLY_SUBDOMAIN']
    Recurly.api_key = organization.recurly_api_key || ENV['RECURLY_API_KEY']
    Recurly.default_currency = organization.recurly_default_currency || 'USD'
    Recurly::Account.create(params)
    params
  end
  
  # def account=
  #   params = {}
  #
  #   if account.present?
  #     params.each do |key, value|
  #       account.send("#{key}=",value)
  #     end
  #     return account
  #   else
  #     Recurly.subdomain = organization.recurly_subdomain || ENV['RECURLY_SUBDOMAIN']
  #     Recurly.api_key = organization.recurly_api_key || ENV['RECURLY_API_KEY']
  #     Recurly.default_currency = organization.recurly_default_currency || 'USD'
  #     Recurly::Account.create(params)
  #   end
  #
  # end
  
  def touch_self(role)
    self.touch
  end
end
