class AddIdsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :id, :integer
  end
end
