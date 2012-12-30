class Actor < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :movies
  
  validates_uniqueness_of :name
  
  def self.find_or_create_and_assign(name, movie)
    actor = self.find_or_create_by_name(name)
    actor.movies << movie
    actor
  end
  
end
