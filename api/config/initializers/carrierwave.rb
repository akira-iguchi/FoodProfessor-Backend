require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      region: 'us-west-1',
      aws_access_key_id: ENV['S3_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['S3_SECRET_KEY']
    }
    config.fog_directory = 'osakaturiba'
    config.asset_host = 'https://s3.amazonaws.com/osakaturiba'
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:].\-+]/
end