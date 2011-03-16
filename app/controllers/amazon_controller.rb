class AmazonController < ApplicationController
	def search
		# accessed as amazon_path -- /amazon/:index/:term
		@term = params[:term]
		@index = params[:index]
		@response = Amazon::Ecs.item_search( @term,  :response_group => "Medium", :search_index => @index )
	end
end