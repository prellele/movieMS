class Movie < ActiveRecord::Base
  attr_accessible :name, :user, :created_at
  
  belongs_to :user
  
  validates_uniqueness_of :name
  
end
