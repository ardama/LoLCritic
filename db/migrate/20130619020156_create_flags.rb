class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.text :body
      t.integer :time
      t.string :rawtime
      t.integer :review_id
      t.integer :user_id

      t.timestamps
    end
  end
end
