class DirectorsController < ApplicationController
  before_filter :authenticate_user!
  
  def movies
    @director = Director.find(params[:director_id])
    @search = @director.movies.search(params[:search])
    @movies = @search.order("name")
  end
  
end
