web: bundle exec unicorn -p $PORT -E $RACK_ENV -c ./config/unicorn.rb
worker: bundle exec sidekiq -e $RACK_ENV -c $SIDEKIQ_CONCURRENCY
