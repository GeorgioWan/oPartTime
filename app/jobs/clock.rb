require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  # handler receives the time when job is prepared to run in the 2nd argument
  handler do |job, time|
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    puts "@@@" + job.center(27) + "@@@"
    puts "@@@" + time.to_s.center(27) + "@@@"
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    
    ## Without sidekiq
    Rails.application.load_tasks
    Rake::Task["production:update_jobs"].invoke
    
    puts "[DONE] #{job} is done!"
    ## with sidekiq
    # DailyUpdateJob.perform_later 
  end

  
  #every 10.seconds, 'DailyUpdateJob'
  
  ## Perform every day at 04:00
  every(1.day, 'DailyUpdateJob', :at => '01:00')
end