namespace :test do
  namespace :system do
    task :with, [:driver] => :environment do |task, args|
      ENV["DRIVER"] = args[:driver]
      Rake::Task["test:system"].invoke
    end
  end
  namespace :all do
    task :with, [:driver] => :environment do |task, args|
      ENV["DRIVER"] = args[:driver]
      Rake::Task["test:all"].invoke
    end
  end
end
