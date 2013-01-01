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
      puts "#{movie.methods.sort}"
      
      if (movie.present?)
        if (self.rating.nil?)
          self.rating = movie.imdbrating
        end
        if (self.length.nil?)
          self.length = movie.runtime || '0'
        end
        if (self.plot.nil?)
          self.plot = movie.plot || ''
        end
        if (self.genres.empty?)
          movie.genre.split(',').each do |g|
            Genre.find_or_create_and_assign(g, self)
          end
        end
        if (self.directors.empty?)
          movie.director.split(',').each do |g|
            Director.find_or_create_and_assign(g, self)
          end
        end
        if (self.actors.empty?)
          movie.actors.split(',').each do |g|
            Actor.find_or_create_and_assign(g, self)
          end
        end
        if (self.poster.nil?)
          require 'curl'
          curl = CURL.new
          curl.get(movie.poster)
          curl.save!("app/assets/images/cover/"+self.id)
          
          self.poster = movie.poster || ''
        end
        if (self.release_date.nil?)
         # puts "#{movie.release_date()}"
          self.release_date = movie.released
        end

        if (self.year.nil?)
          self.year = movie.year || 0
        end
        
        if (self.votes.nil?)
          self.votes = movie.imdbvotes.gsub(',','') || 0
        end
        
        self.save!
      end
    end
  end
end
