class CheckinsController < ApplicationController
	
	def edit
		@checkin = Checkin.find( params[:id] )
	end
	
	def create
		@checkin = Checkin.new( params[:checkin] )

		if @checkin.save
			# todo pop activity feed
			if @checkin.content.present?
				@checkin.user.do_activity( "check in: '#{@checkin.content}' ", @checkin )
			else
				@checkin.user.do_activity( "#{@checkin.expanded_status} ", @checkin.objective )
			end
			
			@checkin.user.save
			
			#Some simple processing of checkins to award points
			if @checkin.status == 'did'
				if @checkin.number_checkin_times > @checkin.objective.times
					pop_flash "Congratulations! You've reached your goal of #{@checkin.objective.times} checkins for #{@checkin.objective.name}"				

					@checkin.user.earn_points_for(@checkin.objective, @checkin.objective.points) unless @checkin.objective.earned_for_period
				else	
					pop_flash "Checkins so far this #{@checkin.objective.period}: #{@checkin.number_checkin_times}"
				end
			end	
			
		else
        	pop_flash "Checkin could not be created.", :error, @checkin
		end
		redirect_to :back
	end

	def update
		@checkin = Checkin.find( params[:id] )

		if @checkin.update_attributes( params[:checkin] )
			count = process_checkin( @checkin )

			pop_flash "Checkin was successfully updated."
		else
			pop_flash "Checkin could not be updated.", :error, @checkin
		end
		redirect_to :back
	end

	def destroy
		@checkin = Checkin.find( params[:id] )
		@checkin.destroy
		pop_flash "Checkin deleted."
		redirect_to :back
	end
	
	
end
