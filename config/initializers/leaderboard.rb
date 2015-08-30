if Rails.env.production?
  $redis = Redis.new(host: "localhost", port: APP_CONFIG['redis_port'], db: 1, password: APP_CONFIG['redis_password'], namespace: 'leaderboard')
else
  $redis = Redis.new(host: "localhost", port: APP_CONFIG['redis_port'], db: 1, namespace: 'leaderboard')
end