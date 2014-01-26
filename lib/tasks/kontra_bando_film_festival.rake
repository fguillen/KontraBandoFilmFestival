namespace :kontra_bando_film_festival do
  desc "Test task"
  task :test => :environment do
    Rails.logger.info( "It is a test" )
  end
end
