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
    target_type = "review"
    review_id = params[:id]
    user_id = current_user.id

    @rating = Rating.upvote(target_type, review_id, user_id)

    respond_to do |format|
      format.js {render 'reviews/upvote'}
    end
	end

	def downvote
    target_type = "review"
    review_id = params[:id]
    user_id = current_user.id

    @rating = Rating.downvote(target_type, review_id, user_id)

    respond_to do |format|
      format.js {render 'reviews/downvote'}
    end
  end


end

