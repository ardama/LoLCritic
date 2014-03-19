class Rating < ActiveRecord::Base
  attr_accessible :target_id, :target_type, :user_id, :value

  belongs_to :user


  def self.find_rating(target_type, target_id, user_id)
  	return Rating.find_by_target_type_and_target_id_and_user_id(target_type, target_id, user_id)
  end

  def self.create_rating(target_type, target_id, user_id, value)
  	return Rating.create(:target_type => target_type, :target_id => target_id, :user_id => user_id, :value => value)
  end

  def self.upvote(target_type, target_id, user_id)

  	# Check for existing rating
  	rating = find_rating(target_type, target_id, user_id)
  	old_value = 0

  	if rating
  		# Save previous rating value
  		old_value = rating.value

  		# If already upvoted, reset
  		if rating.value == 1
  			rating.value = 0

  		# Otherwise register as upvote
  		else
  			rating.value = 1
  		end
  		rating.save

  	# Create new rating if one does not exist	
  	else
  		rating = create_rating(target_type, target_id, user_id, 1)
  	end

  	# Calculate difference
  	diff = rating.value - old_value

  	# Check if Review or Comment
  	if target_type == "review"
  		target = Review.find(target_id)
  	elsif target_type == "comment"
  		target = Comment.find(target_id)
  	end

  	# Update rating of Review/Comment
  	if target
  		target.change_rating(diff)
  	end

  	return rating
  end

  def self.downvote(target_type, target_id, user_id)

  	# Check for existing rating
  	rating = find_rating(target_type, target_id, user_id)
  	old_value = 0

  	if rating
  		# Save previous rating value
  		old_value = rating.value

  		# If already downvoted, reset
  		if rating.value == -1
  			rating.value = 0

  		# Otherwise register as downvote
  		else
  			rating.value = -1
  		end
  		rating.save

  	# Create new rating if one does not exist	
  	else
  		rating = create_rating(target_type, target_id, user_id, -1)
  	end

  	# Calculate difference
  	diff = rating.value - old_value

  	# Check if Review or Comment
  	if target_type == "review"
  		target = Review.find(target_id)
  	elsif target_type == "comment"
  		target = Comment.find(target_id)
  	end

  	# Update rating of Review/Comment
  	if target
  		target.change_rating(diff)
  	end

  	return rating
  end


end
