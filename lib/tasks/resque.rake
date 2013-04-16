require 'resque/tasks'

task 'resque:setup' => :environment do
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
  Resque.logger = Logger.new('log/resque.log')
end