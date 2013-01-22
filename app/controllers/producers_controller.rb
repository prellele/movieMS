class ProducersController < ApplicationController
  before_filter :authenticate_user!
  
  def movies
    @producer = Producer.find(params[:producer_id])
    @search = @producer.movies.search(params[:search])
    @movies = @search.order("name")
  end
  
end
