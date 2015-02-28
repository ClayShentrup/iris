require 'thor/rails'

# Thor task to import hospitals using Socrata
#
# ==== Options
# * <tt>--quiet, -q</tt> - Suppress output
#
class ImportHospitals < Thor
  include Thor::Rails
  default_task :import
  class_option :quiet, aliases: '-q', desc: 'Suppress output'

  desc 'import', 'import or update existing hospitals using Socrata'
  def import
    output 'Starting hospital import...'

    total_rows = Socrata::CreateOrUpdateProviders.call do |index|
      indicate_progress(index)
    end

    output "\nWent through #{total_rows} hospitals."
  end

  private

  def indicate_progress(index)
    output("\r#{index + 1} hospitals processed.", :green, false)
  end

  def output(*args)
    say(*args) unless quiet?
  end

  def quiet?
    options.fetch('quiet', false)
  end
end
