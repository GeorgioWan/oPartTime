namespace :dev do
  desc "Rebuild and initial system data"
  task :rebuild => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :build_all => ["dev:rebuild", "db:seed"]
end