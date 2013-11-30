class AddSecondToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :second, :integer
  end
end
