class MovieattributesController < ApplicationController
  before_filter :authenticate_user!
  
  def movies
    @producer = Producer.find(params[:actor_id])
    @search = @producer.movies.search(params[:search])
    @movies = @search.order("name")
  end
  
end
