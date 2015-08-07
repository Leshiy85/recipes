class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Your account has been created succefully"
			redirect_to recipes_path
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:success] = "Your profile has been updated succesfully"
			redirect_to recipes_path #TODO change to show user page
		else
			render 'edit'
		end
	end

	def show
		@user = User.find(params[:id])
		@recipes = @user.recipes.paginate(page: params[:page], per_page: 3)
	end

	private

		def user_params
			params.require(:user).permit(:username, :email, :password)
		end
end