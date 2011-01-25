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
	end
	
	def edit
		@contact = Contact.find( params[:id] )
	end
	
	def create
		@contact = Contact.new( params[:contact] )
		@contact.ip = request.ip

		if @contact.save
			pop_flash "Contact was successfully created."
		else
        	pop_flash "Contact could not be created.", :error, @contact
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
