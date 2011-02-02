class StaticPagesController < ApplicationController
	
	before_filter   :require_admin, :except => [ :show  ]
	
	def admin
		@pages = StaticPage.all
	end

	def show
		if params[:permalink]
			@static_page = StaticPage.find_by_permalink( params[:permalink] )
			raise ActiveRecord::RecordNotFound if @static_page.nil?
		else
			@static_page = StaticPage.find( params[:id] )
		end
		
		unless @static_page.redirect_path.blank?
			redirect_to @static_page.redirect_to, :status => :moved_permanently
			return false
		end
		
		@title = @static_page.title
		
		render :layout => 'underground'
	end

	def new
		@static_page = StaticPage.new 
	end

	def edit
		@static_page = StaticPage.find( params[:id] )
	end

	def create
		@static_page = StaticPage.new params[:static_page]
		@static_page.permalink = @static_page.title.gsub(/\W/, "-").downcase if @static_page.permalink.blank?
		
		if @current_site.static_pages << @static_page
			pop_flash 'StaticPage was successfully created.'
			redirect_to admin_static_pages_path
		else
			pop_flash 'Oooops, StaticPage not saved...  ', :error, @static_page
			render :action => :new
		end
	end

	def update
		@static_page = StaticPage.find params[:id]

		if @static_page.update_attributes params[:static_page]
			pop_flash 'StaticPage was successfully updated.'
			redirect_to admin_static_pages_path
		else
			pop_flash 'Oooops, StaticPage not updated... ', :error, @static_page
			render :action => :edit
		end
	end

	def destroy
		@static_page = StaticPage.find params[:id]
		@static_page.destroy
		
		pop_flash 'StaticPage was successfully deleted.'
		redirect_to admin_static_pages_path
	end

end
	