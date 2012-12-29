class Movie < ActiveRecord::Base
  attr_accessible :id, :name, :user, :created_at

  belongs_to :user
  
  validates_uniqueness_of :name
  
  has_many :favorite, :dependent => :destroy
  
end
