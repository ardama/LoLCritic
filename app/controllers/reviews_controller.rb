class ReviewsController < ApplicationController
  before_filter :authenticate_user!

	def new
  end

  def create
    video = Video.find(params[:video_id])
    review = video.reviews.create(params[:review])
    review.set_user_id(current_user.id)
    review.set_flag_times()
    review.rating = 0;
    review.save

  	user = video.user
  	notification = user.notifications.create(
  		:target_type => "review", 
			:target_id => review.id, 
			:author_id => current_user.id)

  	redirect_to video
  end

  def destroy
  	review = Review.find(params[:id])
  	video = review.video_id
  	if current_user.id == review.user_id
  		review.destroy
	  	flash[:success] = "Review has been successfully deleted."

	  	redirect_to video
	  else
	  	puts "Unauthorized delete attempt."
	  end
	end

	def upvote
	end

	def downvote
	end


end

