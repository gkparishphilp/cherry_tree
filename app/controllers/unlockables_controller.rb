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

	def create
		@unlockable = Unlockable.new params[:unlockable]
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
	
end