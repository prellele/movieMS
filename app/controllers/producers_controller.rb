class ProducersController < MovieattributesController 
  def get_root_relation
    Producer.find(params[:producer_id])
  end
end
