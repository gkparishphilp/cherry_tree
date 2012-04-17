class StoreController < ApplicationController
  def index
    render :layout => 'store'
  end

  def show
    render :layout => 'application'
  end

end
