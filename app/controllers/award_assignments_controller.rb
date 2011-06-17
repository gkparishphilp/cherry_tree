class AwardAssignmentsController < ApplicationController
	before_filter :get_child
	
	def create
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		if params[:award_assignment][:asin].present?
			# first, try to create an award from Amazon
			@award = Award.create_from_amazon( params[:award_assignment] )
		else 
			# maybe lookup an existing award
			@award = Award.find_by_id( params[:award_assignment][:award_id] )
		end
		# if all else fails, create a new award from params
		@award ||= Award.create( :name => params[:award_assignment][:award_name], 
								:description => params[:award_assignment][:award_description], 
								:creator_id => @current_user.id, :creator_type => 'User' )

		@assignment = @current_user.created_award_assignments.new( params[:award_assignment] )
		@assignment.award = @award
		@assignment.user = @child
		@assignment.status = 'active'
		if @assignment.save
			redirect_to child_award_assignments_path( @child )
		else
			pop_flash "There was a problem granting the reward", :error, @assignment
			redirect_to :back
		end
		
	end
	
	def index
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		@assignments = @child.award_assignments
		@awards = @current_user.created_awards.map{ |award| 
			[ "#{award.name} - #{award.award_type} (#{award.point_cost})", award.id ]
		}
		
		@new_assignment = @child.award_assignments.new
	end
	
	def update
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		
		@assignment = AwardAssignment.find params[:id]
		@assignment.update_attributes( :status => params[:status])
		redirect_to :back
	end
	
	def new
		@new_assignment = AwardAssignment.new
		@time_awards = Site.first.created_awards.where( :category => 'time' )
		@money_awards = Site.first.created_awards.where( :category => 'money' )
		@fun_awards = Site.first.created_awards.where( :category => 'fun' )
		@stuff_awards = Site.first.created_awards.where( :category => 'stuff' )
	end
	
	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
end