class CreateMoviesResolutions < ActiveRecord::Migration
  def self.up
  
    create_table :resolutions do |t|
      t.string :name
      t.timestamps
    end 
    
    create_table :movies do |t|
      t.string :name
      t.string :resolution_id
      t.integer :user_id
      t.timestamps :created_at
      t.timestamps
    end 

  end
end
