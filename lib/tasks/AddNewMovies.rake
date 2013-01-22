require 'fileutils'

namespace :db do
  task :add_new_movies => :environment do
    if File.exists?("movies.txt")
      File.open("movies.txt", 'r') do |f|
        f.readline.split(',').each do |moviename|
          user = User.find(1)
          if Movie.where(:name => moviename).empty?
            @movie = Movie.new()
            @movie.name = moviename
            @movie.created_at = DateTime.now
            @movie.fill_with_dbinfo
            @movie.save
            @movie.users << user
          else
            movie = Movie.where(:name => moviename).first
            movie.users << user
          end
        end
      end
      File.delete("movies.txt")
    end
  end
end
