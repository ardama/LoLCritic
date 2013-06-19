class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value
      t.integer :user_id
      t.integer :target_id
      t.string :target_type

      t.timestamps
    end
  end
end
