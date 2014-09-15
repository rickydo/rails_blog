class ArticlesController < ApplicationController
	# only public methods can be actions for controllers
	# methods in the controller are now called 'actions' 

	# we want the user to be authenticated on every action except for index and show

	http_basic_authenticate_with name: "ricky", password: "celicaGT04", except: [:index, :show]

	def new
		@article = Article.new
		# we call Article.new here so that we can call errors on the form filled out by the user
	end

	def create
		# this method needs to post or save the params returned by the form
		# --------------------------------
		# this renders a plain view in which the params are printed in a hash
		# render plain: params[:article].inspect
		# ---------------------------
		# this returns a security error, we need to specify which params to save
		# @article = Article.new(params[:article])

		# @article.save
		# redirect_to @article
		# -----------------------------------------

		@article = Article.new(article_params)

		if @article.save
			redirect_to @article
		else
			render 'new'
		end

	end

	def show # shows one article
		@article = Article.find(params[:id])
	end

	def index #shows all articles
		@articles = Article.all
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else 
			render 'edit'
		end
	end

	def destroy 
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

		# this pulls the params from the form via '.require' and then 'permit'ing the save of title and text fields
	private # making this method private prevents attackers from manipulating the hash
		def article_params
			params.require(:article).permit(:title, :text)
		end


end