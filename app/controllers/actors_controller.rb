class ActorsController < ApplicationController
  before_filter :authenticate_user!
  
  def movies
    @actor = Actor.find(params[:actor_id])
    @search = @actor.movies.search(params[:search])
    @movies = @search.order("name")
  end
  
end
