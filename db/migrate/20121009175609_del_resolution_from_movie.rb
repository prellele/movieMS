class DelResolutionFromMovie < ActiveRecord::Migration
  def up
    remove_column :movies, :resolution
  end
  
  def down
    add_column :movies, :resolution, :string
  end
end
