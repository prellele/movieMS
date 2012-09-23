class Movie < ActiveRecord::Base
  attr_accessible :name, :user, :resolution
  
  belongs_to :user, :resolution
  
end
