class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :admin
  # attr_accessible :title, :body
  
  attr_accessor :login
  
  has_many :movies
  has_many :favorites, :dependent => :destroy
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  def favorite_for(movie)
    self.favorites.where(movie_id: movie.id).first
  end
  
  def favorite(movie)
    self.favorites.create(movie: movie)
  end
  
end
