class MessagesController < ApplicationController
	
	def new
		@message = Message.new
		render :layout => false  # cause we'll use this inside a tab...
	end
	
	def edit
		@message = Message.find params[:id]
	end
	
	def create
		@message = Message.new params[:message]
		@message.sender = @current_user
		@message.recipient = User.find_by_id( params[:message][:recipient_id] )
		if @message.save
			pop_flash "Message Added"
		else
			pop_flash "Ooops, Message not added", :error, @message
		end
		redirect_to :back
	end
	
end