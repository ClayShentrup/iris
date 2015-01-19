require 'thor/rails'

# Thor task to import systems
# ==== Arguments
#  [import_path] optional file path
#
# ==== Options
# * <tt>--quiet, -q</tt> - Suppress output
#
class SystemImporter < Thor
  DEFAULT_FILE = 'lib/hospital_systems.xls'

  include Thor::Rails
  desc 'import', 'import or update existing systems'
  namespace :system
  class_option :quiet, aliases: '-q', desc: 'Suppress output'

  def import(*args)
    output 'Starting system import...'

    counter = 0
    Systems::Importer.call(file_path) do |message|
      counter += 1
      output("\r#{message}", :yellow, true) if message
      output("\r#{counter} rows processed.", :green, false)
    end
  end

  private

  def file_path(*args)
    @file_path = args.empty? ? DEFAULT_FILE : args.first
  end

  def output(*args)
    say(*args) unless quiet?
  end

  def quiet?
    @quiet ||= options.fetch('quiet', false)
  end
end
