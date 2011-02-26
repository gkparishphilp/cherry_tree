class AwardsController < ApplicationController
	#before_filter	:require_admin, :except => [ :index, :show ]
	
	def admin
		@awards = Award.all
	end
	
	def index
		if @current_user.child?
			# so far, this is only used for the child's treasure chest
			@unlockables = Unlockable.all
			@awards = @current_user.assigned_awards
			render 'index_child'
		else
			# todo -- move awards/new to here?
			redirect_to new_award_path
		end
		
	end
	
	def earned
		@unlockables = @current_user.unlockables
		@awards = @current_user.awards
		@achievements = @current_user.achievement_earnings
	end
	
	def show
		@award = Award.find params[:id]
	end
	
	def new
		@award = Award.new
	end
	
	def edit
		@award = Award.find params[:id]
	end
	
	def unlock
		@award = eval "#{params[:type].capitalize}.find params[:id]"
		success, msg = @current_user.unlock( @award )
		if success
			pop_flash msg
		else
			pop_flash msg, :error
		end
		redirect_to :back
	end

	def create
		if params[:award][:asin]
			@award = Award.create_from_amazon( params[:award] )
		else
			@award = Award.new params[:award]
		end
		
		@award.update_attributes :creator_id => @current_user.id, :creator_type => @current_user.class.name
		
		if @award.save
			process_attachments_for( @award )
			pop_flash "award Created"
		else
			pop_flash "Oooops, award not saved", :error, @award
		end
		redirect_to new_award_path
	end
	
	def update
		@award = Award.find params[:id]
		if @award.update_attributes params[:award]
			process_attachments_for( @award )
			pop_flash "award Updated"
		else
			pop_flash "Oooops, award not saved", :error, @award
		end
		redirect_to :back
	end
	
	def search_amazon	
		@search_term = params[:search_term]
		@search_index = params[:search_index]
		@response = Amazon::Ecs.item_search( @search_term,  :response_group => "Medium", :search_index => @search_index )

		
	end
		
end