class Review < ActiveRecord::Base
  attr_accessible :body, :rating, :user_id, :video_id, :flags_attributes

  belongs_to :user
  belongs_to :video
  has_many :comments, :dependent => :destroy
  has_many :flags, :dependent => :destroy

  accepts_nested_attributes_for :flags, :reject_if => lambda { |f| f[:body].blank? || f[:rawtime].blank?}, :allow_destroy => true


  def set_user_id(user_id)
    self.user_id = user_id
    self.save
  end

  def change_rating(diff)
    self.rating += diff
    self.save
  end

  def set_flag_times()
    self.flags.each do |i|
      i.convert_to_seconds()
    end
  end

  def generate_time()
    current_time = Time.new
    review_time = self.created_at
    diff = current_time - review_time
    unit = " minute"
    if diff < 60
      return "just now"
    elsif diff < 3600
      diff = diff / 60
      unit = " minute"
    elsif diff < 86400
      diff = diff / 3600
      unit = " hour"
    else
      diff = diff / 86400
      unit = " day"
    end
    diff = diff.round.to_s
    if diff != "1"
      unit += "s"
    end
    return diff + unit + " ago"
  end

end
