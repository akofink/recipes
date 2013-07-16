CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
  }
  config.fog_directory  = 'akrecipes'                     # required
end
