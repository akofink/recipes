namespace :db do
  namespace :data do
    desc 'generate lorem ipsum data'
    task generate: :environment do
      require './db/data/seed_development_data'
      SeedDevelopmentData.run!
    end
  end
end
