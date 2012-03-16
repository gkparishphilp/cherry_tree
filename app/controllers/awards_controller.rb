class AwardsController < ApplicationController
	#before_filter	:require_admin, :except => [ :index, :show ]
	
	def admin
		@awards = Award.all
	end
	
	def index
		if @current_user.child?
			# so far, this is only used for the child's treasure chest
			@award_assignments = @current_user.award_assignments
			@fonts = Font.all
			@stickers = Sticker.all
			@backgrounds = Background.all
			render 'index_child'
		else
			# todo -- move awards/new to here?
			redirect_to new_award_path
		end
		
	end
	
	def print
		@award = Award.find params[:id]
		@child = Child.find params[:child_id]
		owning = @child.ownings.find_by_ownable_id_and_ownable_type( @award.id, 'Award' )
		@cert_number = "000#{owning.id}"
		render :show, :layout => 'certificate'
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
		@award = eval "#{params[:type].capitalize}.find( params[:id] )"
		success, msg = @current_user.unlock( @award )
		if success
			pop_flash "Congratulations, ask your <br>parent to check their email <br>for your prize!", :award_message
			@current_user.do_activity( "Unlocked the award: '#{@award.name}'!", @award )
			redirect_to print_award_url( @award, :child_id => @current_user.id, :host => request.host )
		else
			pop_flash msg, :error
			redirect_to :back
			
		end
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
	
	
		
end