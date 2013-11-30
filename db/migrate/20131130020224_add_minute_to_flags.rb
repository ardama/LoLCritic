class AddMinuteToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :minute, :integer
  end
end
