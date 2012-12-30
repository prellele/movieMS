class AddMoreInformationsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :length, :string
    add_column :movies, :plot, :text
    add_column :movies, :poster, :string
    add_column :movies, :director, :string
    add_column :movies, :release_date, :date
    add_column :movies, :votes, :integer
    add_column :movies, :year, :integer
    add_column :movies, :trailer_url, :string
  end
end
