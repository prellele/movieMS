class Movie < ActiveRecord::Base
  attr_accessible :id, :name, :rating, :user, :created_at

  belongs_to :user
  
  validates_uniqueness_of :name
  
  has_many :favorite, :dependent => :destroy
  
  def got_rating?
    if (self.rating.nil?)
      search = Imdb::Search.new(self.name).movies.first
      movie = Imdb::Movie.new(search.id)
      self.rating = movie.rating()
      self.save!
    end
  end
  
end
