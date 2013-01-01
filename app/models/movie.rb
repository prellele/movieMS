class Movie < ActiveRecord::Base
  attr_accessible :id, :name, :rating, :length, :plot, :poster, :release_date, :year, :votes, :trailer_url, :user, :created_at

  belongs_to :user
  
  validates_uniqueness_of :name
  
  has_many :favorites, :dependent => :destroy
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :directors
  has_and_belongs_to_many :actors
  
  
  def genres_string
    self.genres.map{ |g| g.name }.join(', ')
  end
  
  def directors_string
    self.directors.map{ |d| d.name }.join(', ')
  end
  
  def actors_string
    self.actors.map{ |a| a.name }.join(', ')
  end
  
  def got_everything?
    if (self.rating.nil? || self.length.nil? || self.plot.nil? || self.poster.nil? || self.release_date.nil? || self.votes.nil? || self.year.nil? || self.genres.empty?)
      require "net/http"
      movie = Imdb::Search.new(:title => self.name).movie
      
      if (movie.present?)
        if (self.rating.nil? && movie.respond_to?('imdbrating'))
          self.rating = movie.imdbrating
        end
        if (self.length.nil? && movie.respond_to?('runtime'))
          self.length = movie.runtime
        end
        if (self.plot.nil? && movie.respond_to?('plot'))
          self.plot = movie.plot
        end
        if (self.genres.empty? && movie.respond_to?('genre') && !movie.genre.blank?)
          movie.genre.split(', ').each do |g|
            Genre.find_or_create_and_assign(g, self)
          end
        end
        if (self.directors.empty? && movie.respond_to?('director') && !movie.actors.blank?)
          movie.director.split(', ').each do |g|
            Director.find_or_create_and_assign(g, self)
          end
        end
        if (self.actors.empty? && movie.respond_to?('actors') && !movie.actors.blank?)
          movie.actors.split(', ').each do |g|
            Actor.find_or_create_and_assign(g, self)
          end
        end
<<<<<<< HEAD
        if (self.poster.nil?)
          require 'curl'
          curl = CURL.new
          curl.get(movie.poster)
          curl.save!("app/assets/images/cover/"+self.id)
          
          self.poster = movie.poster || ''
=======
        if (self.poster.nil? && movie.respond_to?('poster'))
          self.poster = movie.poster 
>>>>>>> 35e01659958f10471dba2269c8bc987b4b7362e0
        end
        if (self.release_date.nil? && movie.respond_to?('released'))
          self.release_date = movie.released 
        end

        if (self.year.nil? && movie.respond_to?('year'))
          self.year = movie.year
        end
        
        if (self.votes.nil? && movie.respond_to?('imdbvotes') && !movie.imdbvotes.blank?)
          self.votes = movie.imdbvotes.gsub(',','') 
        end
        
        self.save!
      end
    end
  end
end
