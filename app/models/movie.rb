class Movie < ActiveRecord::Base
  attr_accessible :name, :user, :resolution
  
  belongs_to :user
  
  validates :name, :uniqueness => {:scope => :resolution}
  
  AVAILABLE_RESOLUTIONS = ['1080p' , '720p']
  
end
