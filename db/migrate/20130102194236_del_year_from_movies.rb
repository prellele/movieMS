class DelYearFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :year
  end
end
