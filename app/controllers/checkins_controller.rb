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
			
			if @checkin.status == 'did'
				pop_msg = @checkin.process_checkin
				pop_flash pop_msg
			else
				pop_flash "Thanks for checking in!  Keep working on it, you're doing great."
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
