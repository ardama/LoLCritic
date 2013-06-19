class Comment < ActiveRecord::Base
  attr_accessible :body, :rating, :review_id

  belongs_to :user
  belongs_to :review

  def set_user_id(user_id)
    self.user_id = user_id
    self.save
  end
  
  def change_rating(diff)
    self.rating += diff
    self.save
  end
end
