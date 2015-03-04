class Orphan < ActiveRecord::Base

  has_many :assigned_posts, dependent: :destroy
  has_many :posts, through: :assigned_posts
  
  has_many :subscriptions
  has_many :users, through: :subscriptions
  
  belongs_to :organization

  validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :hashtag, presence: true, uniqueness: true
  
  before_validation :set_hashtag, if: Proc.new { |o| o.hashtag.blank? }

  mount_uploader :avatar, AvatarUploader
  mount_uploader :photo, PhotoUploader
  
  after_save :create_recurly_plan
  after_save :create_medium_recurly_plan
  after_save :create_maximum_recurly_plan

  def to_s
    "#{first_name} #{last_name}".squish
  end
  
  def plan_id
    "child_sponsorship_#{id}"
  end
  
  def medium_plan_id
    "child_medium_sponsorship_#{id}"
  end
  
  def maximum_plan_id
    "child_maximum_sponsorship_#{id}"
  end
  
  def recurly_plan
    Recurly::Plan.find(plan_id) rescue nil
  end
  
  def medium_recurly_plan
    Recurly::Plan.find(medium_plan_id) rescue nil
  end
  
  def maximum_recurly_plan
    Recurly::Plan.find(maximum_plan_id) rescue nil
  end
  
  def create_recurly_plan
    plan = recurly_plan

    plan ||= Recurly::Plan.create(
      :plan_code            => plan_id,
      :name                 => "Sponsorship for #{first_name} #{last_name}".squish,
      :unit_amount_in_cents => { 'USD' => 34_00, 'EUR' => 8_00 },
      :setup_fee_in_cents   => { 'USD' => 0, 'EUR' => 0 },
      :plan_interval_length => 1,
      :plan_interval_unit   => 'months',
      :tax_exempt           => true
    )
  end
  
  def create_medium_recurly_plan
    plan = medium_recurly_plan

    plan ||= Recurly::Plan.create(
      :plan_code            => medium_plan_id,
      :name                 => "Sponsorship for #{first_name} #{last_name}".squish,
      :unit_amount_in_cents => { 'USD' => 68_00, 'EUR' => 8_00 },
      :setup_fee_in_cents   => { 'USD' => 0, 'EUR' => 0 },
      :plan_interval_length => 1,
      :plan_interval_unit   => 'months',
      :tax_exempt           => true
    )
  end
  
  def create_maximum_recurly_plan
    plan = maximum_recurly_plan

    plan ||= Recurly::Plan.create(
      :plan_code            => maximum_plan_id,
      :name                 => "Sponsorship for #{first_name} #{last_name}".squish,
      :unit_amount_in_cents => { 'USD' => 200_00, 'EUR' => 8_00 },
      :setup_fee_in_cents   => { 'USD' => 0, 'EUR' => 0 },
      :plan_interval_length => 1,
      :plan_interval_unit   => 'months',
      :tax_exempt           => true
    )
  end
  
  def set_hashtag
    self.hashtag = "#{first_name}#{last_name}".squish.gsub(/(\W|\d)/, "")
  end

end
