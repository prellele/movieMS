class AddTrailerUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :trailer_url, :string
  end
end
