class RegistrationsController < Devise::RegistrationsController

	respond_to :json

	before_filter :configure_permitted_parameters

	protected


	def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation,:full_name, :first_name, :last_name) }
	  end


	def sign_up_params


	    params.require(:user).permit(:email, :password, :password_confirmation,:full_name, :first_name, :last_name)
	end


	def after_sign_up_path_for(resource)
		root_path

		
	end

	def after_inactive_sign_up_path_for(resource)
		new_user_session_path
	end

end







