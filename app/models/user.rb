class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  has_many :subscriptions
  has_many :orphans, through: :subscriptions
  
  def account
    @account ||= Recurly::Account.find(account_id) rescue nil
  end
  
  def account_id
    "recurly_#{id.to_s}"
  end
  
  def account=
    params = {}
    
    if account.present?
      params.each do |key, value|
        account.send("#{key}=",value)
      end
      return account
    else
      Recurly::Account.create(params)
    end
    
  end
end
