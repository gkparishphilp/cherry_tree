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
	
	def search_amazon
		Amazon::Ecs.configure do |options| 
			options[:aWS_access_key_id] = AMAZON_ID
			options[:aWS_secret_key] = AMAZON_SECRET
		end
		
		@search_term = params[:search_term]
		@response = Amazon::Ecs.item_search(@search_term, {:response_group => "Large", :sort => "salesrank"})
	end
		
end