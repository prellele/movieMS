class CreateMoviesResolutions < ActiveRecord::Migration
  def change
  
    create_table :resolutions do |t|
      t.string :name
      t.timestamps
    end 
    
    add_index :resolution_id
    
    create_table :movies do |t|
      t.string :name
      t.references :resolution
      t.references :user
      t.timestamps :created_at
      t.timestamps
    end 
    
    add_index :movie_id, :resolution_id
  end
end
