class AddFavoriteTable < ActiveRecord::Migration
  def change
    create_table :favorites do |f|
      f.references :user
      f.references :movie
      f.timestamps
    end
  end
end
