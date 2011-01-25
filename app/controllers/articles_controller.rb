class ArticlesController < ApplicationController
	before_filter :get_owner
	
	def new
		@article = Article.new
	end
	
	def edit
		@article = Article.find params[:id]
	end
	
	def create
		@article = Article.new params[:article]

		if @owner.articles << @article
			pop_flash 'Article was successfully created.'
			@owner.do_activity( "write", @article )
			redirect_to :back
		else
			pop_flash 'Oooops, Article not saved...', :error, @article
			render :action => :new
		end
	end

	def update
		@article = Article.find  params[:id] 
		if @article.update_attributes params[:article]
			pop_flash 'Article was successfully updated.'
			redirect_to :back
		else
			pop_flash 'Oooops, Article not updated...', :error, @article
			render :action => :edit
		end
	end

	def destroy
		@article = Article.find params[:id]
		@article.destroy
		pop_flash 'Article was successfully deleted.'
		redirect_to :back
	end
	
	private
	
	def get_owner
		require_admin_or_contributor
		@owner = @current_user
	end

end
