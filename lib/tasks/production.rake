namespace :production do
  
  desc "Depoly with admin"
  task :init => ["db:migrate", "db:seed"]
  
  desc "Manually task for updating posts(jobs) status."
  task :update_jobs => :environment do
    
    jobs = Job.where(["updated_at < ?", 15.days.ago]) # Pick up jobs out of deadline
    
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
end