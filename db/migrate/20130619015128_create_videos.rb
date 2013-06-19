class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.string :title
      t.text :description
      t.decimal :rating
      t.integer :num_ratings
      t.integer :total_rating
      t.integer :user_id

      t.timestamps
    end
  end
end
