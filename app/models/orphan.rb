class Orphan < ActiveRecord::Base

  has_many :assigned_posts, dependent: :destroy
  has_many :posts, through: :assigned_posts
  
  has_many :subscriptions
  has_many :users, through: :subscriptions
  
  belongs_to :organization

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :hashtag, presence: true, uniqueness: true
  
  before_validation :set_hashtag, if: Proc.new { |o| o.hashtag.blank? }

  mount_uploader :avatar, AvatarUploader
  mount_uploader :photo, PhotoUploader
  
  after_save :create_recurly_plan

  def to_s
    "#{first_name} #{last_name}"
  end
  
  def plan_id
    "child_sponsorship_#{id}"
  end
  
  def recurly_plan
    Recurly::Plan.find(plan_id) rescue nil
  end
  
  def create_recurly_plan
    plan = recurly_plan

    plan ||= Recurly::Plan.create(
      :plan_code            => plan_id,
      :name                 => "Sponsorship for #{first_name} #{last_name}",
      :unit_amount_in_cents => { 'USD' => 10_00, 'EUR' => 8_00 },
      :setup_fee_in_cents   => { 'USD' => 0, 'EUR' => 0 },
      :plan_interval_length => 1,
      :plan_interval_unit   => 'months',
      :tax_exempt           => true
    )
  end
  
  def set_hashtag
    self.hashtag = "#{first_name}#{last_name}".gsub(/(\W|\d)/, "")
  end

end
