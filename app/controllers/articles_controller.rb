class ArticlesController < ApplicationController
	
	def new
		@article = Article.new
		render :layout => '3col'
	end
	
	def edit
		@article = Article.find params[:id]
		unless author_owns( @article )
			redirect_to root_path
			return false
		end
		render :layout => '3col'
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
		unless author_owns( @article )
			redirect_to root_path
			return false
		end

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

end