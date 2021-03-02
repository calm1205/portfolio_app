CarrierWave.configure do |config|

  config.fog_public = false

  if Rails.env.production?
    config.root = "#{Rails.root}/public"
  end
end