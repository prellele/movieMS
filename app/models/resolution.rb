class Resolutions < ActiveRecord::Base
  attr_accessible :id, :name
  
  validates_uniqueness_of :name
end
