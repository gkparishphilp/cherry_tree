class CheckinsController < ApplicationController
	
	def edit
		@checkin = Checkin.find( params[:id] )
	end
	
	def create
		@checkin = @current_user.checkins.new( params[:checkin] )

		if @checkin.save
			if @checkin.objective_assignment.present?
				@checkin.user.do_activity( "did '#{@checkin.objective_assignment.objective.name}'.", @checkin )
				# todo -- auto-add content as comment
			else
				@checkin.user.do_activity( " said: '#{@checkin.content}' ", @checkin )
			end
			
			@checkin.award_points
			@checkin.user.save

			#pop_msg = @checkin.get_banner_message
			#pop_flash pop_msg

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
