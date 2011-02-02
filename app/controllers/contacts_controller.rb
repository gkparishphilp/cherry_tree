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
		if user = User.find_by_email( @contact.email )
			@contact.user = user
			@contact.save
			pop_flash "Thanks for your submission!", :success
		else
			user = User.new :email => @contact.email
			if user.save
				@contact.user = user
				@contact.save
				pop_flash "Thanks for your submission!", :success
			else
				pop_flash "There was a problem with your submission.", :error, user
			end
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
