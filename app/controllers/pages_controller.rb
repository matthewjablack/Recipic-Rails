class PagesController < ApplicationController

	def home
		if user_signed_in?
			@recipes = Recipe.all.page(params[:page]).per(15)
		end
	end


end