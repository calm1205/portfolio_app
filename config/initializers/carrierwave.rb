CarrierWave.configure do |config|

  if Rails.env.production?
    # config.root = "#{Rails.root}/public"
  end
end