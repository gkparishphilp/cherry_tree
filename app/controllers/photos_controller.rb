class PhotosController < ApplicationController
	before_filter	:get_user
	
	def index
		@photos = @user.photo_albums.first.photos
	end
	
	def new
		@photo = Photo.new
	end
	
	def show
		@photo = Photo.find( params[:id] )
	end
	
	def create
		@photo = @user.photo_albums.first.photos.new( params[:photo] )
		if @photo.save
			process_attachments_for( @photo )
			pop_flash "Photo Added!"
			redirect_to :back
		else
			pop_flash "Oooops, photo not saved", :error, @photo
			redirect_to :back
		end
	end
	
	private
	
	def get_user
		@user = User.find( params[:user_id] )
	end
	
end