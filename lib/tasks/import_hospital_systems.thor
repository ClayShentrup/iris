require 'thor'
require 'thor/rails'

# Thor task to import systems
# ==== Arguments
#  [import_path] optional file path
#
# ==== Options
# * <tt>--quiet, -q</tt> - Suppress output
#
class ImportHospitalSystems < Thor
  include Thor::Rails

  default_task :import

  desc 'import', 'import or update existing hospital systems'
  class_option :quiet, aliases: '-q', desc: 'Suppress output'
  def import(*_args)
    output 'Starting system import...'

    counter = 0
    HospitalSystems::Importer.call.each do |message|
      counter += 1
      output("\r#{message}", :yellow, true) if message
      output("\r#{counter} rows processed.", :green, false)
    end
    nil
  end

  private

  def output(*args)
    say(*args) unless quiet?
  end

  def quiet?
    @quiet ||= options.fetch('quiet', false)
  end
end
