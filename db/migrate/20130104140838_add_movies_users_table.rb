class AddMoviesUsersTable < ActiveRecord::Migration
  def change
    create_table :movies_users, :id => false do |md|
      md.integer :movie_id
      md.integer :user_id
    end
  end
end
