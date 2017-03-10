class PostsController < ApplicationController
	include SessionsHelper
	
	before_action :set_user, only: [:new, :create]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(ext_post_params)
		if @post.save
			flash[:success] = "Успех!"
			redirect_to @post
		else
			flash.now[:error] = "Введите корректные данные!"
			render 'new'
		end
	end

	private
	def post_params
		params.require(:post).permit(:title, :content)
	end

	def ext_post_params
		ppr = post_params
		ppr[:user] = current_user
		ppr
	end

	def set_user
		unless signed_in?
			flash[:error] = "Войдите, чтобы создавать посты!"
			redirect_to root_path
		end
	end
end
