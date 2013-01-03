class AddOrginalTitleToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :original_title, :string
  end
end
