# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

shelter_of_love = Organization.find_by_name("Shelter of Love") || Organization.new


shelter_of_love.name = "Shelter of Love"
shelter_of_love.domain = "localhost"

shelter_of_love.save

if shelter_of_love.twitter_account.nil?
  twitter_account = TwitterAccount.new

  twitter_account.username = "ShelterOfLoveKH"

  twitter_account.consumer_key = ENV['CONSUMER_KEY']
  twitter_account.consumer_secret = ENV['CONSUMER_SECRET']
  twitter_account.access_token = ENV['ACCESS_TOKEN']
  twitter_account.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  
  twitter_account.organization = shelter_of_love

  twitter_account.save
end

plan = Recurly::Plan.find('child') rescue nil

plan ||= Recurly::Plan.create(
  :plan_code            => 'child',
  :name                 => 'Sponsor a Child',
  :unit_amount_in_cents => { 'USD' => 10_00, 'EUR' => 8_00 },
  :setup_fee_in_cents   => { 'USD' => 60_00, 'EUR' => 45_00 },
  :plan_interval_length => 1,
  :plan_interval_unit   => 'months',
  :tax_exempt           => true
)

puts plan