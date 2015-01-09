# Thor task to analyze code with JSCS
# Execute it with `thor jscs:check`
class Jscs < Thor
  desc 'check', 'run node jscs and report js style errors'
  def check
    included_files = ['app/assets/javascripts', 'spec/javascripts']
    cmd = %w[jscs --reporter=inline --verbose] + included_files

    require 'overcommit/utils'
    result = Overcommit::Utils.execute(cmd)
    puts result.stdout unless result.status == 0
    exit result.status
  end
end
