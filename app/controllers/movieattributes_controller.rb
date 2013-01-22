class MovieattributesController < ApplicationController
  before_filter :authenticate_user!
  
  def movies
    @search = get_root_relation.movies.search(params[:search])
    @movies = @search.order("name")
  end
  
end
