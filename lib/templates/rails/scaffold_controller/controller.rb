class <%= controller_class_name %>Controller < ApplicationController

	def admin
		@<%= plural_table_name %> = <%= orm_class.all(class_name) %>
	end
	
	def index
		@<%= plural_table_name %> = <%= orm_class.all(class_name) %>
	end

	def show
		@<%= singular_table_name %> = <%= orm_class.find( class_name, " params[:id] " ) %>
	end
	
	def new
		@<%= singular_table_name %> = <%= orm_class.build(class_name) %>
	end
	
	def edit
		@<%= singular_table_name %> = <%= orm_class.find( class_name, " params[:id] " ) %>
	end
	
	def create
		@<%= singular_table_name %> = <%= orm_class.build( class_name, " params[:#{singular_table_name}] " ) %>

		if @<%= orm_instance.save %>
			pop_flash "<%= human_name %> was successfully created."
		else
        	pop_flash "<%= human_name %> could not be created.", :error, @<%= singular_table_name %>
		end
		redirect_to :back
	end

	def update
		@<%= singular_table_name %> = <%= orm_class.find(class_name, " params[:id] " ) %>

		if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
			pop_flash "<%= human_name %> was successfully updated."
		else
			pop_flash "<%= human_name %> could not be updated.", :error, @<%= singular_table_name %>
		end
		redirect_to :back
	end

	def destroy
		@<%= singular_table_name %> = <%= orm_class.find class_name, " params[:id] " %>
		@<%= orm_instance.destroy %>
		pop_flash "<%= human_name %> deleted."
		redirect_to :back
	end

end
