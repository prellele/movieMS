class GenresController < MovieattributesController 
  def get_root_relation
    Genre.find(params[:genre_id])
  end
end
