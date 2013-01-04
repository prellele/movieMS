class CleanupMoviesTable < ActiveRecord::Migration
  def change
    remove_column :movies, :director
    remove_column :movies, :votes
    remove_column :movies, :trailer_url
    remove_column :movies, :director_id
    remove_column :movies, :year_id
    remove_column :movies, :genres_id
  end
end
