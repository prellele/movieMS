class Producer < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :movies
  
  validates_uniqueness_of :name
  
  def self.find_or_create_and_assign(name, movie)
    producer = self.find_or_create_by_name(name)
    producer.movies << movie
    producer
  end
  
end
