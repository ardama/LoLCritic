class CommentsController < ApplicationController
	before_filter :authenticate_user!

	def new
	end

	def create
		review = Review.find(params[:review_id])
		comment = review.comments.create(params[:comment])
		comment.set_user_id(current_user.id)

		comment.rating = 0;
    	comment.save

		user = review.user
		notification = user.notifications.create(
			:target_type => "comment", 
			:target_id => comment.id, 
			:author_id => current_user.id)

		redirect_to review.video
	end

	def destroy
		comment = Comment.find(params[:id])
		video = comment.review.video
		if current_user.id == comment.user_id
			comment.destroy
			flash[:success] = "Comment has been successfully deleted."

			redirect_to video
		else
			puts "Unauthorized delete attempt."
		end
	end

	def upvote
    target_type = "comment"
    comment_id = params[:id]
    user_id = current_user.id

    @rating = Rating.upvote(target_type, comment_id, user_id)

    respond_to do |format|
      format.js {render 'comments/upvote'}
    end
	end

	def downvote
    target_type = "comment"
    comment_id = params[:id]
    user_id = current_user.id

    @rating = Rating.downvote(target_type, comment_id, user_id)

    respond_to do |format|
      format.js {render 'comments/downvote'}
    end
  end


end
