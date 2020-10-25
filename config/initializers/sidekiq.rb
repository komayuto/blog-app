Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379') }
  # ENV.fetchでENVがあればREDIS_URLを使いなければredis://localhost:6379を使うという意味
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379')}
  # ENV.fetchでENVがあればREDIS_URLを使いなければredis://localhost:6379を使うという意味
end