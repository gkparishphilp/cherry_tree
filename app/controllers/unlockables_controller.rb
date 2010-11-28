class UnlockablesController < ApplicationController
	before_filter	:require_admin, :except => [ :index, :show ]
	
	def show
		@unlockable = Unlockable.find params[:id]
	end
	
end