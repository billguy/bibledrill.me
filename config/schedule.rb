if @environment == 'production'

  every 1.minute do
    rake "jobs:workoff"
  end
end