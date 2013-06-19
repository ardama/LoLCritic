class Review < ActiveRecord::Base
  attr_accessible :body, :rating, :user_id, :video_id

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

end
