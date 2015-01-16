require 'thor/rails'

# Thor task to import hospitals using Socrata
#
# ==== Options
# * <tt>--quiet, -q</tt> - Suppress output
#
class HospitalImporter < Thor
  include Thor::Rails
  class_option :quiet, aliases: '-q', desc: 'Suppress output'

  desc 'import', 'import or update existing hospitals using Socrata'
  namespace :hospital
  def import
    say 'Starting hospital import...' unless quiet?
    total_rows = Socrata::CreateOrUpdateHospitals.call
    say "Went through #{total_rows} hospitals." unless quiet?
  end

  private

  def quiet?
    options.fetch('quiet', false)
  end
end
