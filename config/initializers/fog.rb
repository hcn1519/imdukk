CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                                            # required
  config.fog_credentials = {
    provider:              'AWS',                                            # required
    aws_access_key_id:     'AKIAJPGLDT6IA3EKDTEA',                           # required
    aws_secret_access_key: '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',       # required
    region:                'ap-northeast-2',                                 # optional, defaults to 'us-east-1'
    endpoint:              'https://s3.ap-northeast-2.amazonaws.com'         # optional, defaults to nil
  }
    config.fog_directory  = 'imdukk'                                         # required
    config.fog_public     = true                                             # optional, defaults to true
end