class MoviesController < ApplicationController

  before_filter :authenticate_user!

  def list
    @movies = Movie.all
  end
  
  def new
    @movie = Movie.new
 
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @post }
    end
  end
  
  def create
    @movie = Movie.new(params[:movie])
 
    respond_to do |format|
      if @movie.save
        format.html  { redirect_to(list_movies_path, :notice => 'movie was successfully created.') }
        format.json  { render :json => @movie, :status => :created, :location => @movie }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end
    
  def update
    @movie = Movie.find(params[:id])
   
    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html  { redirect_to(list_movies_path, :notice => 'movie was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end  
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
   
    respond_to do |format|
      format.html { redirect_to(list_movies_path, :notice => 'movie deleted') }
      format.json { head :no_content }
    end
  end

end
