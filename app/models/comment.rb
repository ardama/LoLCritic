class Comment < ActiveRecord::Base
  attr_accessible :body, :rating, :review_id, :user_id

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

  def generate_time()
    current_time = Time.new
    comment_time = self.created_at
    diff = current_time - comment_time
    unit = " minute"
    if diff < 60
      return "just now"
    elsif diff < 3600
      diff = diff / 60
      unit = " minute"
    elsif diff < 86400
      diff = diff / 3600
      unit = " hour"
    elsif diff < 2592000
      diff = diff / 86400
      unit = " day"
    elsif diff < 31104000
      diff = diff / 2592000
      unit = " month"
    else
      diff = diff / 31104000
      unit = " year"
    end
    diff = diff.round.to_s
    if diff != "1"
      unit += "s"
    end
    return diff + unit + " ago"
  end
end
