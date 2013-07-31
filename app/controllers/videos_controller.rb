class VideosController < ApplicationController
	include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!

  def show
  	@video = Video.find(params[:id])
  	@reviews = @video.reviews.order("rating desc").page(params[:page]).per(8)
		@path = @video.generate_path

		@ratings = current_user.ratings
		@review_ratings = {}
		@comment_ratings = {}

		@ratings.each do |r|
			if r.target_type == "review"
				@review_ratings[r.target_id] = r.value
			elsif r.target_type == "comment"
				@comment_ratings[r.target_id] = r.value
			end
		end
	end

	def index
		@videos = Video.order("rating desc").page(params[:page]).per(12)
	end

	def search
		@videos = Video.search(params[:search]).page(params[:page]).per(12)
		@search = params[:search]
		render "index"
	end

	def new
		@video = Video.new
	end

	def create
		video = Video.new(params[:video])
		if video.save
			flash[:success] = "Video successfully created!"
			redirect_to video
		else
			flash[:error] = "Could not create your video. Please try again."
			redirect_to new_video_path
		end
	end

	def rate
	end

  def edit
    @video = current_user.videos.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @video = current_user.videos.find(params[:id])

    if @video.update_attributes(params[:video])
      flash[:success] = "Successfully updated video!"
    else
      flash[:error] = "Unable to edit - error ocurred!"
      @video = current_user.videos.find(params[:id])
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    video = Video.find(params[:id])
    if current_user.id == video.user_id
      title = video.title
      video.destroy
      flash[:success] = truncate(title, :length => 20) + " has been successfully deleted."
			redirect_to '/account' 
    else
      puts "Unauthorized delete attempt."
    end
  end
end
