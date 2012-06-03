class StoreController < ApplicationController
  def index
    render :layout => 'store'
  end

  def show
	@category = StoreCategory.find_by_short_name params[:id]
	if @category.present?
		@products = @category.products
	else
		@products = Product.all
	end
    render :layout => 'application'
  end

end
