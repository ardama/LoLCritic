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
  def filter_by_tags

    if !params[:position]
      params[:position] = []
    end

    if !params[:focus]
      params[:focus] = []
    end

    filter_tags = [params[:lane]] + params[:position] + params[:focus]
    exclusion = [false, false, false]

    if params[:champion] == "None"
      exclusion[0] = true
    end
    if params[:opponent] == "None"
      exclusion[1] = true
    end
    if params[:lane] == "None"
      if filter_tags == ["None"]
        exclusion[2] = true
      else
        filter_tags = params[:position] + params[:focus]
      end
    end

    @videos = Video.tagged_with([params[:champion]], :on => :champion, :exclude => exclusion[0]) \
      .tagged_with([params[:opponent]], :on => :opponent, :exclude => exclusion[1]) \
      .tagged_with(filter_tags, :exclude => exclusion[2])

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
