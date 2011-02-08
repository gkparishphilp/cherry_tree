class NotesController < ApplicationController
	
	def new
		@note = Note.new
		@recipient_list = @current_user.related_users.map { |u| [ u.nickname( @current_user ), u.id ] }
		
		if @reply_to_note = Note.find_by_id( params[:reply_to] )
			@note.subject = @reply_to_note.subject
		end
			
			 
	end
	
	def edit
		@note = Note.find( params[:id] )
	end
	
	def index
		@inbox_notes = @current_user.note_deliveries.published.unread.order( "created_at desc" ).collect { |deliv| deliv.note }
	end
	
	def show
		@note = Note.find( params[:id] )
		@note.mark_read_by( @current_user )
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
	
	def destroy
		@note = Note.find( params[:id] )
		@note.mark_deleted_by( @current_user )
		pop_flash "Note trashed"
	end
	
end