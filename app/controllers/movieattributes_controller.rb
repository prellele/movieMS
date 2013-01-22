class MovieattributesController < ApplicationController
  before_filter :authenticate_user!
  
  def movies
    @search = get_root_relation.movies.search(params[:search])
    @movies = @search.order("name").paginate(:page => params[:page])
    @sum_movies = @movies.count
    render "movies/index"
  end
  
end
