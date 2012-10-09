module MoviesHelper

  def order_by_links(label, column)
    (column == params[:oder] ? content_tag(:span, label) : link_to(label, list_movies_path(:order => column))).html_safe
  end
  
end
