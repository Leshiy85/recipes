class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.user = User.find(1)

		if @recipe.save
			flash[:success] = "Your was created succesfully!"
			redirect_to recipes_path
		else
			render :new
		end
	end

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:success] = "Your recipe was updated succefully!"
			redirect_to recipe_path(@recipe)
		else
			render :edit
		end
	end

	private

		def recipe_params
			params.require(:recipe).permit(:title, :summary, :description)
		end

end