Sidekiq.configure_client do |config|
  config.redis = {namespace: "staging-creativesatwork"}
end