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
			#pop_flash "Checkin was successfully created."
			
			#Some simple processing of checkin to test logic
			if @checkin.status == 'did'
				if @checkin.process_checkin > @checkin.objective.times
					pop_flash "Congratulations! You've reached your goal of #{@checkin.objective.times} checkins for #{@checkin.objective.name}"				
					#Award points if points have not been previously awarded
					@checkin.user.earn_points_for(@checkin.objective, @checkin.objective.points) unless @checkin.objective.earned_for_period
				else	
					pop_flash "Checkins so far this #{@checkin.objective.period}: #{@checkin.process_checkin}"
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
