class CreateMovies < ActiveRecord::Migration
  def self.up
    
    create_table :movies do |t|
      t.string :name
      t.string :resolution
      t.references :user
      t.timestamps :created_at
      t.timestamps
    end 

  end
end
