class StoreController < ApplicationController
  def index
    render :layout => 'store'
  end

  def show
	@category = StoreCategory.find_by_short_name params[:id]
	@products = @category.products
    render :layout => 'application'
  end

end
