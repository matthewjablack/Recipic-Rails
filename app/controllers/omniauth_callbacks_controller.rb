class OmniauthCallbacksController < Devise::OmniauthCallbacksController


	# def facebook
	# 	binding.pry
	#     # You need to implement the method below in your model (e.g. app/models/user.rb)
	#     @user = User.from_omniauth(request.env["omniauth.auth"])

	#     if @user.persisted?
	#       sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
	#       set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	#     else
	#       session["devise.facebook_data"] = request.env["omniauth.auth"]
	#       redirect_to new_user_registration_url
	#     end
	# end

	def self.provides_callback_for(provider)
		class_eval %Q{
			def #{provider}
				p env["omniauth.auth"]
				user = User.from_omniauth(env["omniauth.auth"], current_user)

				if user.persisted?
					flash[:info] = "Connected through account "
					sign_in_and_redirect(user)	
				else
					session["devise.user_attributes"] = user.attributes
					redirect_to new_user_registration_url
				end
			end
		}
	end

	[:facebook].each do |provider|
		provides_callback_for provider
	end

end
