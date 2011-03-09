class NotesController < ApplicationController
	
	def archive
		@notes = @current_user.note_deliveries.published.order( "created_at desc" ).collect { |deliv| deliv.note }
	end
	
	def customize
		@note = Note.find( params[:id] )
	end
	
	def new
		@note = Note.new
		@recipient_list = @current_user.related_users.map { |u| [ u.nickname( @current_user ), u.id ] }
		
		@note.recipient_id = params[:to] if params[:to].present?
		
		@fonts = @current_user.ownings.fonts.collect{ |o| o.ownable }
		
		if @reply_to_note = Note.find_by_id( params[:reply_to] )
			@note.subject = @reply_to_note.subject
		end
	end
	
	def edit
		@note = Note.find( params[:id] )
	end
	
	def index
		if params[:read]
			@notes = @current_user.note_deliveries.published.read.order( "created_at desc" ).collect { |deliv| deliv.note }
		elsif params[:trash]
			@notes = @current_user.note_deliveries.deleted.order( "created_at desc" ).collect { |deliv| deliv.note }
		else
			@notes = @current_user.note_deliveries.published.unread.order( "created_at desc" ).collect { |deliv| deliv.note }
		end
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
			recipient.do_activity( "Have a new note from #{@note.sender.display_name}", @note )
			pop_flash "Note Added"
			redirect_to customize_note_path( @note )
		else
			pop_flash "Ooops, Note not added", :error, @note
			redirect_to :back
		end
		
	end
	
	def destroy
		@note = Note.find( params[:id] )
		@note.mark_deleted_by( @current_user )
		pop_flash "Note trashed"
		redirect_to notes_path
	end
	
end