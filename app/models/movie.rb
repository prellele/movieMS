class Movie < ActiveRecord::Base
  attr_accessible :id, :name, :rating, :length, :plot, :poster, :release_date, :trailer_url, :user, :original_title, :created_at

  belongs_to :user
  
  validates_uniqueness_of :name
  
  has_many :favorites, :dependent => :destroy
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :directors
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :producers
  
  def genres_string
    self.genres.map{ |g| g.name }.join(', ')
  end
  
  def producers_string
    self.producers.map{ |p| p.name }.join(', ')
  end
  
  def directors_string
    self.directors.map{ |d| d.name}.join(', ')
  end
  
  def actors_string
    self.actors.find(:all, :limit => 5).map{ |a| a.name }.join(', ')
  end
  
  def fill_with_dbinfo
    if (self.rating.nil?)
      movie = TmdbMovie.find(:title => self.name, :limit => 1)
      imdb = ImdbParty::Imdb.new(:anonymize => true)

      movie = imdb.find_movie_by_id(movie.imdb_id)

      puts movie.methods

      if (self.rating.nil?)
        self.rating = movie.rating
      end
      
      self.save!
    end
    if (self.length.nil? || self.plot.nil? || self.poster.nil? || self.release_date.nil? || self.genres.empty? || self.actors.empty? || self.directors.empty?)
      movie = TmdbMovie.find(:title => self.name, :limit => 1)
      
      if (movie.present?)
        if (self.rating.nil?)
          self.rating = movie.vote_average
        end
        if (self.length.nil?)
          self.length = movie.runtime
        end
        if (self.original_title.nil?)
          self.original_title = movie.original_title
        end
        if (self.plot.nil?)
          self.plot = movie.overview
        end
        if (self.genres.empty?)
          movie.genres.each do |g|
            Genre.find_or_create_and_assign(g.name, self)
          end
        end
        if (self.directors.empty?)
          movie.crew.find(:job => 'Director').each do |g|
            Director.find_or_create_and_assign(g.name, self)
          end
        end
        if (self.producers.empty?)
          movie.crew.find(:job => 'Producer').each do |g|
            Producer.find_or_create_and_assign(g.name, self)
          end
        end
        if (self.actors.empty?)
          movie.cast.each do |g|
            Actor.find_or_create_and_assign(g.name, self)
          end
        end
        if (self.poster.nil? && movie.respond_to?('poster_path'))
          require "open-uri"
          if (!movie.poster_path.nil?)
            open("http://cf2.imgobject.com/t/p/w185#{movie.poster_path}") {|f|
              File.open("app/assets/images/cover/#{self.id}.jpg","wb") do |file|
                file.puts f.read
              end
            }
          end
          self.poster = "#{self.id}" || ''
        end
        if (self.release_date.nil?)
          self.release_date = movie.release_date
        end     
        if (self.votes.nil?)
          self.votes = movie.vote_count 
        end
        
        self.save!
      end
    end
  end
  
  def reset_data
    self.rating = nil
    self.length = nil
    self.plot = nil
    self.poster =nil
    self.release_date = nil
    self.votes = nil
    self.year = nil
    self.actors.map{ |a| a.destroy }
    self.directors.map{ |a| a.destroy }
    self.genres.map{ |a| a.destroy }
    self.save
  end
  
end
