class NotesController < ApplicationController
	
	def new
		@note = Note.new
		@recipient_list = @current_user.children
		if @current_user.is_child?
			@recipient_list += @current_user.supporters
		end
		if @reply_to_note = Note.find_by_id( params[:reply_to] )
			@note.subject = @reply_to_note.subject
		end
			
			 
	end
	
	def edit
		@note = Note.find( params[:id] )
	end
	
	def index
		@notes = @current_user.notes.order( :subject )
	end
	
	def show
		@note = Note.find( params[:id] )
		#@note.update_attributes :unread => false
	end
	
	def create
		@note = @current_user.sent_notes.new( params[:note] )
		recipient = User.find_by_id( params[:note][:recipient_id] )
		if @note.save
			@note.deliver_to( recipient )
			if @note.points > 0
				recipient.earn_points_for( @note )
				recipient.do_activity( "Receive #{@note.points} points from #{@note.sender.display_name}", @note )
			else
				recipient.do_activity( "Have a note from #{@note.sender.display_name}", @note )
			end
			pop_flash "Note Added"
		else
			pop_flash "Ooops, Note not added", :error, @note
		end
		redirect_to :back
	end
	
end