if Rails.env.production?
  $redis = Redis.new(host: ENV['redis_host'], port: ENV['redis_port'], db: 1, password: ENV['redis_password'], namespace: 'leaderboard')
else
  $redis = Redis.new(host: ENV['redis_host'], port: ENV['redis_port'], db: 1, namespace: 'leaderboard')
end