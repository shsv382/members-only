class UsersController < ApplicationController
#	before_action :signed_in_user, only: :index

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Добро пожаловать!"
			redirect_to @user
		else
			flash.now[:error] = "Введите корректные данные!"
			render :new
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

#	def signed_in_user
#		unless signed_in?
#			flash[:error] = "Зарегистрируйтесь или войдите!"
#			redirect_to signin_url
#		end
#	end

	def correct_user
      	@user = User.find(params[:id])
      	redirect_to(root_url) unless current_user?(@user)
	end
end
