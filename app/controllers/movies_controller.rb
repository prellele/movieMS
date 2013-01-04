class MoviesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_user!
  
  def list
    @search = Movie.search(params[:search])
    @favorites = current_user.favorites.all
    @movies = @search.paginate(:page => params[:page])
    @sum_movies = Movie.all.count
    @new_movies = Movie.find(:all, :order => "created_at desc", :limit => 10)
  end
  
  def get_order_by
    ["name", "user_id", "created_at"].include?(params[:order]) ? params[:order] : "name"
  end
  
  def new
    @movie = Movie.new
 
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @movie }
    end
  end
  
  def create
    @movie = current_user.movies.create(params[:movie])
    @movie.fill_with_dbinfo
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
    File.delete("#{Rails.root}/app/assets/images/cover/#{params[:id]}.jpg") if FileTest.exists?("#{Rails.root}/app/assets/images/cover/#{params[:id]}.jpg") 
    @movie.destroy
   
    respond_to do |format|
      format.html { redirect_to(list_movies_path, :notice => 'movie deleted') }
      format.json { head :no_content }
    end
  end
  
  def favorite
    if movie = Movie.find(params[:movie_id])
      if favorite = current_user.favorite_for(movie)
        if params[:create] == "false"
          favorite.destroy
        end
      else
        if params[:create] == "true"
          current_user.favorite(movie)
        end
      end
      
      respond_to do |format|
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.json { head :not_found }
      end
    end  
  end

  def reset_data
    @movie = Movie.find(params[:movie_id])
    @movie.original_title = nil
    @movie.rating = nil
    @movie.length = nil
    @movie.plot = nil
    @movie.poster =nil
    @movie.release_date = nil
    @movie.actors.map{ |a| a.destroy }
    @movie.directors.map{ |a| a.destroy }
    @movie.genres.map{ |a| a.destroy }
    @movie.producers.map{ |a| a.destroy }
    @movie.save!
    respond_to do |format|
        format.html { render :action => 'edit' }
        format.json { head :ok }
    end
  end

  def load_info 
    @movie = Movie.find(params[:movie_id])
    @movie.fill_with_dbinfo()
    respond_to do |format|
        format.html { render :action => 'edit' }
        format.json { head :ok }
    end
  end

  private
  
  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
