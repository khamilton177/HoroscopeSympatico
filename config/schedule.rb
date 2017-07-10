# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 24.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, {:error => './cron_error.log', :standard => './cron.log'}
# set :job_template, nil
# set :environment => 'staging'

every 1.day, :at => '9:00pm' do
  runner "ApplicationController.new.do_daily_all_predicts", :environment => 'development' ,:output => 'cron.log'
end
