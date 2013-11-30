class HomeController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :help]

  # TODO: Clean up the code reptition
	def index
		@user = User.new
    unless params[:filter]
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
    else
      @videos = Video.tagged_with(params[:filter])
      if params[:tab]
        @tab = params[:tab].downcase
        if @tab == "new"
          @videos = Video.tagged_with(params[:filter]).order("id asc")#.page(params[:page]).per(12)
        elsif @tab == "best"
          @videos = Video.tagged_with(params[:filter]).order("rating desc")#.page(params[:page]).per(12)
        end
      else
        @tab = "popular"
      end

    end
		if current_user
			@homepage = false
		else
			@homepage = true
		end
	end

  # TODO: Extend functionality to nearest match if no exact matches are found
  # TODO: Accommodate when not all parameters are selected
  def filter_by_tags

    filter_tags = [params[:lane]]
    filter_tags += params[:position] + params[:focus]

    @videos = Video.tagged_with([params[:champion]], :on => :champion).tagged_with([params[:opponent]], :on => :opponent).tagged_with(filter_tags)
    respond_to do |format|
      format.js
    end
  end

	def help
	end

	def account
	    @videos = current_user.videos.page(params[:page]).per(8)
	    #@review_ratings = filter_ratings("review")
	end
	
end
