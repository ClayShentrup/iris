# We use our own implementation of cleaning the db with transactions
# because we would need to require rails_helpers to use
# `config.use_transactional_fixtures` and we don't always need it.
# Feature specs, however, need to use the database_cleaner gem in order to get
# truncation strategy. Our own transaction strategy conflicts with that so
# we only switch it on for features.
module DatabaseCleaningStrategy
  def self.call(rspec_config)
    rspec_config.around do |example|
      if example.metadata[:type] == :feature
        example.run
      else
        ActiveRecord::Base.transaction do
          example.run
          fail ActiveRecord::Rollback
        end
      end
    end
  end
end
