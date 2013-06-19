class Flag < ActiveRecord::Base
  attr_accessible :body, :rawtime, :review_id, :time, :user_id

  belongs_to :review

  # Converts raw input of time (string) into seconds (integer)
  def convert_to_seconds()
  	regex = /(\d{1,2}):(\d{2})/
  	match = regex.match(self.rawtime)
  	minutes = match[1].to_i
  	seconds = match[2].to_i
  	total = 60*minutes + seconds
  	self.time = total
  	self.save
  end
end
