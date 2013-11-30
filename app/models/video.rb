class Video < ActiveRecord::Base
  attr_accessible :description, :link, :num_ratings, :rating, :title, :total_rating, :user_id

  belongs_to :user
  has_many :reviews, :dependent => :destroy

  acts_as_taggable_on :champion, :opponent, :lane, :position, :focus

  def extract_id()
  	match = self.link.match(/^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/)
  	if match && match[7].length==11
  		return match[7]
  	else
  		return 'NPdw1BOzFmE'
  	end
  end

  def vid_init(params)

    # Basic Attributes
		self.title = params[:video][:title]
		self.link = params[:video][:link]
		self.user_id = params[:video][:user_id]

		# Tagging Attributes
		self.champion_list.add(params[:video][:champion])
		self.opponent_list.add(params[:video][:opponent])
		self.lane_list.add(params[:video][:lane])
		params[:video][:position].each do |p|
			self.position_list.add(p)
		end
		if params[:video][:focus].length > 1
			params[:video][:focus].each do |f|
				self.focu_list.add(f)
			end
		else
			self.focu_list = "None"
		end

		self.num_ratings = 0
		self.rating = 0
		self.total_rating = 0

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
    return "http://i1.ytimg.com/vi/" + self.extract_id() + "/hqdefault.jpg"
  end

  def champion_image()
    name = self.champion_list[0].delete('.').delete(' ').delete('\'')
    return "Champs/" + name + ".png"
  end

  def opponent_image()
    name = self.opponent_list[0].delete('.').delete(' ').delete('\'')
    return "Champs/" + name + ".png"
  end

  def generate_time()
    current_time = Time.new
    video_time = self.created_at
    diff = current_time - video_time
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
    if diff == "1"
      unit += "s"
    end
    return diff + unit + " ago"
  end

  def generate_description()
    d = "Playing "
    unless self.champion_list[0] == "None"
      d += "<u class='description-champion'>" + self.champion_list[0] + "</u>"
    end
    unless self.opponent_list[0] == "None"
      d += " against "
      d += "<u class='description-opponent'>" + self.opponent_list[0] + "</u>"
    end
    unless self.lane_list[0] == "None"
      d += " in the "
      d += "<u>" + self.lane_list[0] + "</u>"
    end
    if self.position_list.length > 1
      d += " as the team's "
      self.position_list.each do |p|
        if p.length > 0
          d += "<u>" + p + "</u>"
          d += ", "
        end
      end
      d = d[0..-3]
    end
    return d
  end


  def add_tag(tag,type)
    if type == "focus"
      self.focus_list.add(tag);
    elsif type == "champion"
      self.champion_list.add(tag);
    elsif type == "opponent"
      self.opponent_list.add(tag);
    elsif type == "lane"
      self.lane_list.add(tag);
    elsif type == "position"
      self.position_list.add(tag);
    end
  end

        
      
  def get_champion()
    return self.champion_list[0]   
  end
  def get_opponent()
    return self.opponent_list[0]   
  end

end
