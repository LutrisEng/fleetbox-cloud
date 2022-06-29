# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

if Rails.env.staging? || Rails.env.production?
  Rake::Task['assets:precompile'].enhance do
    Rake::Task['lookbook:previews:preparse'].invoke
  end
end
