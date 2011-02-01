class ContactsController < ApplicationController

	def admin
		@contacts = Contact.all
	end
	
	def index
		@contacts = Contact.all
	end

	def show
		@contact = Contact.find( params[:id] )
	end
	
	def new
		@contact = Contact.new
		render :layout => 'underground'
	end
	
	def edit
		@contact = Contact.find( params[:id] )
	end
	
	def create
		@contact = Contact.new( params[:contact] )
		@contact.ip = request.ip
		if @current_user.anonymous?
			user = User.find_by_email params[:email]
			
			if user.nil?
				user = User.new :email => params[:email]
				if user.save
					@contact.user = user
					@contact.save
					pop_flash "Thanks for submitting your email!  We'll be in touch soon.", :success
				else
					pop_flash "There was a problem saving your email address", :error, user
				end
			end
		else
			@contact.user = @current_user
			@contact.save
			pop_flash "Thanks for submitting your email! We'll be in touch soon.", :success
			
		end
		redirect_to :back
	end

	def update
		@contact = Contact.find( params[:id] )

		if @contact.update_attributes( params[:contact] )
			pop_flash "Contact was successfully updated."
		else
			pop_flash "Contact could not be updated.", :error, @contact
		end
		redirect_to :back
	end

	def destroy
		@contact = Contact.find( params[:id] )
		@contact.destroy
		pop_flash "Contact deleted."
		redirect_to :back
	end

end
