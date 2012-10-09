module MoviesHelper

  def order_by_links
    links = ""
    {"Name" => "name", "created_at" => "created at"}.each do |column, label|
      if params[:order] == column
        links += content_tag(:span, "Order by #{label}")
      else
        links += link_to label, list_movies_path(:order => column)
      end
    end
    links.html_safe
  end

  def order_by_by_links(label, column)
    (column == params[:oder] ? content_tag(:span, label) : link_to(label, list_movies_path(:order => column))).html_safe
  end
  
end
