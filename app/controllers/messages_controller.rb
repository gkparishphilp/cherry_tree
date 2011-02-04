class MessagesController < ApplicationController
	
	def new
		@message = Message.new
		render :layout => false  # cause we'll use this inside a tab...
	end
	
	def edit
		@message = Message.find params[:id]
	end
	
	def index
		@messages = @current_user.messages
		@sent_messages = @current_user.sent_messages
	end
	
	def create
		dfs
		@message = Message.new params[:message]
		@message.sender = @current_user
		@message.recipient = User.find_by_id( params[:message][:recipient_id] )
		if @message.save
			if @message.points > 0
				@message.recipient.earn_points_for( @message )
				@message.recipient.do_activity( "Receive #{@message.points} points from #{@message.sender.relation_to( @message.recipient )}", @message )
			else
				@message.recipient.do_activity( "Have a message from #{@message.sender.relation_to( @message.recipient )}", @message )
			end
			pop_flash "Message Added"
		else
			pop_flash "Ooops, Message not added", :error, @message
		end
		redirect_to :back
	end
	
end