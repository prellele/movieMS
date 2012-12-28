class FavoritesController < ApplicationController
  
  def new
    @favorite = Favorite.new
 
    respond_to do |format|
      format.json  { render :json => @favorite }
    end
  end
  
  def create
    @favorite = current_user.favorites.create(params[:favorite])
 
    respond_to do |format|
      if @favorite.save
        format.json  { render :json => @favorite, :status => :created, :location => @favorite }
      else
        format.json  { render :json => @favorite.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @favorite = Favorite.find(params[:id])
  end
    
  def update
    @favorite = Favorite.find(params[:id])
   
    respond_to do |format|
      if @favorite.update_attributes(params[:movie])
        format.html  { redirect_to(list_movies_path, :notice => 'movie was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @favorite.errors, :status => :unprocessable_entity }
      end
    end
  end  
  
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
   
    respond_to do |format|
      format.html { redirect_to(list_movies_path, :notice => 'movie deleted') }
      format.json { head :no_content }
    end
  end
end
