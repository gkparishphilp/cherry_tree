class GamesController < ApplicationController

	def show
		@game = Game.find( params[:id] )
		@current_user.play( @game )
	end
	
end