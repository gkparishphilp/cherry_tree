class RelationsController < ApplicationController
	
	def create
		@relation = Relation.new( params[:relation] )
		@related_user = User.find_or_initialize_by_email( :email => @relation.email, :name => @relation.name, :password => '1234' )
		@related_user.save
		@relation.user = @related_user
		
		if @relation.save
			pop_flash "Relation was successfully created."
		else
        	pop_flash "Relation could not be created.", :error, @relation
		end
		redirect_to :back
	end


	def destroy
		@relation = Relation.find( params[:id] )
		@relation.destroy
		pop_flash "Relation deleted."
		redirect_to :back
	end
	
	
end
