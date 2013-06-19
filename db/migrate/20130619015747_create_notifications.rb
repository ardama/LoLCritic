class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :author_id
      t.integer :target_id
      t.string :target_type

      t.timestamps
    end
  end
end
