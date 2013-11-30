class FlagsController < ApplicationController
	def add
		flag = Flag.find(params[:id])
		@flags = []
		if flag
			if !(session[:flags].include? flag.id)
				(session[:flags] ||= []) << flag.id
			end
			session[:flags].each do |f|
				@flags << Flag.find(f)
			end
			@flags.sort_by! {|f| f.time}
		end
		respond_to do |format|
    		format.js  {render 'flags/add'}
    	end
	end
end
