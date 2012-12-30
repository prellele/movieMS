class AddReferecesFromMoviesToDirectorYearAndGenres < ActiveRecord::Migration
  def change
    change_table :movies do |m|
      m.references :director
      m.references :year
      m.references :genres
    end
  end
end
