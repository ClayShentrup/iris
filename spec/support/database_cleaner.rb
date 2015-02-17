require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    # Database Cleaner 1.4.0 has a bug that blows away schema_migrations.
    # This hack prevents that. There is a spec that will fail when the bug is
    # fixed, instructing removing this stuff.
    # DatabaseCleaner.clean_with(:truncation,
    #   { except: %w[public.schema_migrations] }
    # )

    # In case we did an unclean shutdown on a previous run.
    DatabaseCleaner.clean_with(:truncation,
                               except: %w[public.schema_migrations],
    )
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation,
                               { except: %w[public.schema_migrations] }
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
