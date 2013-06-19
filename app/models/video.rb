class Video < ActiveRecord::Base
  attr_accessible :description, :link, :num_ratings, :rating, :title, :total_rating, :user_id

  belongs_to :user_id
  has_many :reviews, :dependent => :destroy


  def extract_id()
  	match = self.link.match(/^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/)
  	if match && match[7].length==11
  		return match[7]
  	else
  		return 'NPdw1BOzFmE'
  	end
  end

  def self.search(phrase)
    search_condition = "%" + phrase + "%"
    return Video.where("UPPER(title) LIKE UPPER(?)", search_condition)
  end

  def add_rating(value)
	self.total_rating += value.to_i
	self.num_ratings += 1
	self.rating = self.total_rating/self.num_ratings.to_f
    self.save
  end

  def overwrite_rating(old_value, new_value)
	self.total_rating -= old_value.to_i
	self.total_rating += new_value.to_i
	self.rating = self.total_rating/self.num_ratings.to_f
    self.save
  end

  def generate_path()
    return "http://youtube.com/embed/"+self.extract_id()
  end

  def generate_thumbnail()
    return "http://img.youtube.com/vi/" + self.extract_id() + "/0.jpg"
  end

end
