class AwardsController < ApplicationController
	#before_filter	:require_admin, :except => [ :index, :show ]
	
	def admin
		@awards = Award.all
	end
	
	def index
		@awards = Award.all
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
		@award = Award.find params[:id]
		success, msg = @current_user.unlock( @award )
		if success
			pop_flash msg
		else
			pop_flash msg, :error
		end
		redirect_to :back
	end

	def prize_shelf
		@awards = Award.available( @current_user )
	end

	def create
		if params[:award][:asin]
			@award = Award.create_from_amazon(params[:award] )
			redirect_to edit_award_path( @award )
			return false
		elsif params[:award][:id]
			@award = Award.find params[:award][:id] 
			@award.points = params[:award][:points]
			@award.level = params[:award][:level]
		else
			@award = Award.new params[:award]
		end
		
		if @award.save
			process_attachments_for( @award )
			pop_flash "award Created"
		else
			pop_flash "Oooops, award not saved", :error, @award
		end
		redirect_to :back
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