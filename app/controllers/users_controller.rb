class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update]


	def index
		@users = User.paginate(page: params[:page], per_page: 3)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Your account has been created succefully"
			session[:user_id] = @user.id
			redirect_to recipes_path
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		if @user.update(user_params)
			flash[:success] = "Your profile has been updated succesfully"
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def show
		@recipes = @user.recipes.paginate(page: params[:page], per_page: 3)
	end

	private

		def user_params
			params.require(:user).permit(:username, :email, :password)
		end

		def set_user
			@user = User.find(params[:id])
		end

		def require_same_user
			if current_user != @user
				flash[:danger] = "You can only edit your own profile"
				redirect_to root_path
			end
		end
end