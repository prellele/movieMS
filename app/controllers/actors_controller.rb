class ActorsController < MovieattributesController 
  def get_root_relation
    Actor.find(params[:actor_id])
  end
end
