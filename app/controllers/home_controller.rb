class HomeController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :help]

	def index
		@user = User.new
		@videos = Video.all
		if params[:tab]
			@tab = params[:tab].downcase
			if @tab == "new"
				@videos = Video.order("id asc")#.page(params[:page]).per(12)
			elsif @tab == "best"
				@videos = Video.order("rating desc")#.page(params[:page]).per(12)
			end
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
