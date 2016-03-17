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
    jobs = Job.where(["updated_at < ?", 15.days.ago]) # Pick up jobs out of deadline
    
    if !jobs.empty?
      jobs.each do |j|
        if j.updated_at < 25.days.ago
          temp = j.title
          j.destroy # Out of 25 days, should be destroied
          puts "[DESTROY] TITLE: #{temp}, its over 25 days."
        else
          if j.accepted == "pass"     # Let public jobs off
            temp = j.updated_at       # Keep the current updated_at
            j.update accepted: "wait" # Turn accepted to "wait"
            j.update updated_at: temp # Set back updated_at
            puts "[OFF] TITLE: #{j.title}, its over 15 days."
          end
        end
      end
    end
    
    ## with sidekiq
    # DailyUpdateJob.perform_later 
  end

  
  # every 10.seconds, 'DailyUpdateJob'
  
  ## Perform every day at 04:00
  every(1.day, 'DailyUpdateJob', :at => '01:00')
end