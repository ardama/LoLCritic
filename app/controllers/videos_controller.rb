class VideosController < ApplicationController
	include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!

  def show
  	@video = Video.find(params[:id])
  	@owner = User.find(@video.user_id)
  	@review = Review.new
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
		video = Video.new

		# Basic Attributes
		video.title = params[:video][:title]
		video.link = params[:video][:link]
		video.user_id = params[:video][:user_id]

		# Tagging Attributes
		video.champion_list.add(params[:video][:champion])
		video.opponent_list.add(params[:video][:opponent])
		video.lane_list.add(params[:video][:lane])
		params[:video][:position].each do |p|
			video.position_list.add(p)
		end
		if params[:video][:focus].length > 1
			params[:video][:focus].each do |f|
				video.focu_list.add(f) 
			end
		else
			video.focu_list = "None"
		end

		video.num_ratings = 0
		video.rating = 0
		video.total_rating = 0


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
