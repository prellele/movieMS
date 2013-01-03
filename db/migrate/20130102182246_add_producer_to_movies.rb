class AddProducerToMovies < ActiveRecord::Migration
  def change
    create_table :producers do |a|
      a.string :name
      a.timestamps
    end
    create_table :movies_producers, :id => false do |ma|
      ma.integer :movie_id
      ma.integer :producer_id
    end
  end
end
