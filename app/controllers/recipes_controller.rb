class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all.page(params[:page]).per(15)
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		if @recipe.save

			redirect_to root_path
			# redirect_to root_path
		else
			redirect_to :back
			@recipe.errors.full_messages.each do |message|
				flash[:alert] = message
			end
		end
	end

	def show
		@recipe = Recipe.find(params[:id])
	end


	private


		def recipe_params
			params.require(:recipe).permit(:name, :description, :body, :user_id)
		end


end
