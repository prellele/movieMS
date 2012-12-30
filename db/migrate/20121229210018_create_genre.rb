class CreateGenre < ActiveRecord::Migration
  def change
    create_table :genres do |g|
      g.string :name
      g.timestamps
    end
  end
end
