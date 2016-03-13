require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  # handler receives the time when job is prepared to run in the 2nd argument
  handler do |job, time|
    puts "===> Running #{job}, at #{time}"
    DailyUpdateJob.perform_later
  end

  # Perform every day at 04:00
  every(1.day, 'DailyUpdateJob', :at => '04:00')
end