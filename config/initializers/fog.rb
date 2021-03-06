CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['S3_KEY'],                        # required
    :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
    :region                 => ENV['S3_REGION'],                  # optional, defaults to 'us-east-1'
    :host                   => 's3-us-west-2.amazonaws.com',             # optional, defaults to nil
    :endpoint               => 'https://s3-us-west-2.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = ENV['S3_BUCKET']                     # required
  config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end