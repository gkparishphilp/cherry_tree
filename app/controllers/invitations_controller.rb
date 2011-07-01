class InvitationsController < ApplicationController
	
	before_filter :get_child, :except => :accept_invite
	
	def new
		@invitation = Invitation.new
	end
	
	
	def create
		unless @child.parents.include?( @current_user )
			pop_flash "Access Denied", :error
			redirect_to :back
			return false
		end
		@invitation = Invitation.new( params[:invitation] )
		
		@invitation.creator = @current_user
		@invitation.child = @child
		invitee = User.find_by_email( @invitation.email )
		if invitee.nil?
			invitee = User.new( :email => @invitation.email, :display_name => @invitation.name )
			unless invitee.save
				pop_flash "There was a problem with your invitation", :error, invitee
				redirect_to :back
				return false
			end
		end

		@invitation.user = invitee
		
		if invitee.registered?
			invitee.relate_to( @invitation.child, :as => @invitation.role, :nickname => @invitation.nickname )
		end
		
		if @invitation.save
			UserMailer.send_invitation_for_child( @invitation ).deliver
			pop_flash "Invitation Sent!"
		else
			pop_flash "Could not send invitation", :error, @invitation
		end
		
		redirect_to :back
	end
	
	def accept_invite
		logout( @current_user ) unless @current_user.anonymous?
		@invitation = Invitation.find_by_code( params[:code] )
		@invitation.user.relate_to( @invitation.child, :as => @invitation.role, :nickname => @invitation.nickname )
		if @invitation.user.registered?
			redirect_to login_path( :credential => @invitation.user.email )
		else
			redirect_to register_invitee_sessions_path( :id => @invitation.user.id, :invite_code => @invitation.code )
		end
		
	end

	private
	
	def get_child
		@child = Child.find( params[:child_id] )
	end
	
	
end

