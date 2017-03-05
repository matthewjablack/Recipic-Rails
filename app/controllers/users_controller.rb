class UsersController < ApplicationController

	def index
	end


	def show
		@user = User.find(params[:id])
		Rails.logger.info "User auth_token: " + @user.authentication_token
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to root_path
		else
			render action: 'edit'
			flash[:alert] = @user.errors.full_messages
		end
	end


	private


		def user_params
			params.require(:user).permit(:full_name, :email, :first_name, :last_name).to_h
		end



end