class JournalEntriesController < ApplicationController
	before_filter :get_child
	
	def new
		@entry = JournalEntry.new
	end
	
	def edit
		@entry = JournalEntry.find( params[:id] )
	end
	
	def index
		if @current_user.child?
			@entries = @current_user.journals.first.journal_entries
			render 'index_child'
		else
			@entries = @child.journals.first.journal_entries
			render 'index_adult'
		end
	end
	
	def show
		@entry = JournalEntry.find( params[:id] )
		@comment = Comment.new
		@commentable = @entry
		@commentable_parent = @child
		@fonts = [] << @entry.font if @entry.font.present?
		if @current_user.child?
			render 'show_child'
		else
			render 'show_adult'
		end
	end
	
	def create

		@entry = @current_user.journals.first.journal_entries.new( params[:journal_entry] )
		if @entry.save
			@current_user.do_activity( "Write in journal", @entry )
			pop_flash "Entry Added"
		else
			pop_flash "Ooops, Entry not added", :error, @entry
		end
		redirect_to customize_child_journal_entry_path( @current_user, @entry )
	end
	
	def update
		@entry = JournalEntry.find( params[:id] )
		@entry.update_attributes( params[:journal_entry] )
		redirect_to child_journal_entry_path( @current_user, @entry )
	end
	
	def customize
		@entry = JournalEntry.find( params[:id] )
		
		@stickers = @current_user.ownings.stickers
		
		@fonts = @current_user.ownings.fonts.collect{ |o| o.ownable }
		@backgrounds = @current_user.ownings.backgrounds.collect{ |o| o.ownable }
		
	end
	
	def destroy
		@entry = JournalEntry.find( params[:id] )
		@entry.mark_deleted_by( @current_user )
		pop_flash "Entry trashed"
		redirect_to journal_entries_path
	end
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end