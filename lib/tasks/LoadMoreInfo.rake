require 'fileutils'

namespace :db do
  task :load_more_info => :environment do
    @movies = Movie.all
    @movies.each do |movie|
      movie.fill_with_dbinfo
    end
    sleep(5)
  end
end
