class AddDirectorTableActorTableAndJoins < ActiveRecord::Migration
  def change
    create_table :actors do |a|
      a.string :name
      a.timestamps
    end
    create_table :directors do |d|
      d.string :name
      d.timestamps
    end
    create_table :actors_movies, :id => false do |ma|
      ma.integer :movie_id
      ma.integer :actor_id
    end
    create_table :directors_movies, :id => false do |md|
      md.integer :movie_id
      md.integer :director_id
    end
    
  end
end
