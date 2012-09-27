class Movie < ActiveRecord::Base
  attr_accessible :name, :user, :resolution
  
  belongs_to :users
  belongs_to :resolutions
  
end
