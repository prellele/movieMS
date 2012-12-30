class AddMovieGenresTable < ActiveRecord::Migration
  def change
    create_table :genres_movies, :id => false do |t|
      t.integer :movie_id
      t.integer :genre_id
    end
  end
end
