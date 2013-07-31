class HomeController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :help]

	def index
		@user = User.new
		@videos = Video.order("rating desc")#.page(params[:page]).per(12)
		if params[:tab]
			@tab = params[:tab].downcase
		else
			@tab = "popular"
		end
		if current_user
			@homepage = false
		else
			@homepage = true
		end
	end

	def help
	end

	def account
	    @videos = current_user.videos.page(params[:page]).per(8)
	    @review_ratings = filter_ratings("review")
	end
	
end
