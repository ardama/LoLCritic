class Notification < ActiveRecord::Base
  attr_accessible :author_id, :target_id, :target_type, :user_id

  belongs_to :user
end
