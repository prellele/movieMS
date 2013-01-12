namespace :db do
  task :add_new_movies => :environment do
    File.open("/home/lprelle/movies.txt, "r", "\r").each do |moviename|
      user = User.find(1)
      if Movie.where(:name => moviename).empty?
   			current_time = DateTime.now
        @movie = user.movies.new()
        @movie.name = moviename
        @movie.created_at = current_time
        @movie.fill_with_dbinfo
        @movie.save
      else
        movie = Movie.where(:name => moviename)
        movie.users << user
      end
    end
  end
end
