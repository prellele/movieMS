class Movie < ActiveRecord::Base
  attr_accessible :name, :user, :created_at

#  self.primary_key = "name" 
  
  belongs_to :user
  
  validates_uniqueness_of :name
  
  has_many :favorite, :dependent => :destroy
end
