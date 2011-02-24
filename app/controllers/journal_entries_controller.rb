class JournalEntriesController < ApplicationController
	
	def new
		@entry = JournalEntry.new
	end
	
	def edit
		@entry = JournalEntry.find( params[:id] )
	end
	
	def index
		@entries = @current_user.journals.first.journal_entries
	end
	
	def show
		@entry = JournalEntry.find( params[:id] )
	end
	
	def create

		@entry = @current_user.journals.first.journal_entries.new( params[:journal_entry] )
		if @entry.save
			@current_user.do_activity( "Wrote in journal", @entry )
			pop_flash "Entry Added"
		else
			pop_flash "Ooops, Entry not added", :error, @entry
		end
		redirect_to :back
	end
	
	def destroy
		@entry = JournalEntry.find( params[:id] )
		@entry.mark_deleted_by( @current_user )
		pop_flash "Entry trashed"
		redirect_to journal_entries_path
	end
	
end