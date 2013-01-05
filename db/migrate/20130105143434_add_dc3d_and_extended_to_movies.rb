class AddDc3dAndExtendedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :threed, :boolean, :default => 0
    add_column :movies, :extended, :boolean, :default => 0
    add_column :movies, :dc, :boolean, :default => 0
  end
end
