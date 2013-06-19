class Rating < ActiveRecord::Base
  attr_accessible :target_id, :target_type, :user_id, :value

  belongs_to :user

end
