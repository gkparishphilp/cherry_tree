class UnlockablesController < ApplicationController
	#before_filter	:require_admin, :except => [ :index, :show ]
	
	def admin
		@unlockables = Unlockable.all
	end
	
	def index
		@unlockables = Unlockable.all
	end
	
	def show
		@unlockable = Unlockable.find params[:id]
	end
	
	def new
		@unlockable = Unlockable.new
	end
	
	def edit
		@unlockable = Unlockable.find params[:id]
	end
	
	def unlock
		@unlockable = Unlockable.find params[:id]
		success, msg = @current_user.unlock( @unlockable )
		if success
			pop_flash msg
		else
			pop_flash msg, :error
		end
		redirect_to :back
	end

	def create
		if asin = params[:unlockable][:asin]
			search_index = params[:unlockable][:search_index]
			@unlockable = Unlockable.create_from_amazon( asin, search_index )
			redirect_to edit_unlockable_path( @unlockable )
			return false
		else
			@unlockable = Unlockable.new params[:unlockable]
		end
		
		if @unlockable.save
			process_attachments_for( @unlockable )
			pop_flash "Unlockable Created"
		else
			pop_flash "Oooops, unlockable not saved", :error, @unlockable
		end
		redirect_to :back
	end
	
	def update
		@unlockable = Unlockable.find params[:id]
		if @unlockable.update_attributes params[:unlockable]
			process_attachments_for( @unlockable )
			pop_flash "Unlockable Updated"
		else
			pop_flash "Oooops, unlockable not saved", :error, @unlockable
		end
		redirect_to :back
	end
	
	def search_amazon
		
		@search_term = params[:search_term]
		@search_index = params[:search_index]
		@response = Amazon::Ecs.item_search( @search_term,  :response_group => "Medium", :search_index => @search_index )
	end
		
end