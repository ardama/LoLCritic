class CommentsController < ApplicationController
	before_filter :authenticate_user!

	def new
	end

	def create
		review = Review.find(params[:review_id])
		comment = review.comments.create(params[:comment])
		comment.set_user_id(current_user.id)

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
	end

	def downvote
	end


end
