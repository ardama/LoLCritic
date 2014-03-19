class FlagsController < ApplicationController
	def select
		@flag = Flag.find(params[:id])
		@flags = []
		if @flag
			if !(session[:flags].include? @flag.id)
				(session[:flags] ||= []) << @flag.id
				action = 'add'
			else
				session[:flags] -= [@flag.id] 
				action = 'remove'
			end
			session[:flags].each do |f|
				@flags << Flag.find(f)
			end
			@flags.sort_by! {|f| f.time}
		end
		respond_to do |format|
    		format.js  {render 'flags/' + action}
    	end
	end

	def remove
		@flag = Flag.find(params[:id])
		@flags = []
		session[:flags] -= [@flag.id]

		session[:flags].each do |f|
			@flags << Flag.find(f)
		end
		
		@flags.sort_by! {|f| f.time}
		respond_to do |format|
			format.js  {render 'flags/remove'}
		end
	end
end
