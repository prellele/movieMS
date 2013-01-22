class DirectorsController < MovieattributesController 
  def get_root_relation
    Director.find(params[:director_id])
  end
end
