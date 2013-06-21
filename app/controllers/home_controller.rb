class HomeController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :help]

	def index
		@user = User.new
	end

	def help
	end

	def account
    @videos = current_user.videos.page(params[:page]).per(8)
    @review_ratings = filter_ratings("review")
	end
	
end
