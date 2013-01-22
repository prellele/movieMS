class GenresController < ApplicationController
  before_filter :authenticate_user!
  
  def movies
    @genre = Genre.find(params[:genre_id])
    @search = @genre.movies.search(params[:search])
    @movies = @search.order("name")
  end
  
end
