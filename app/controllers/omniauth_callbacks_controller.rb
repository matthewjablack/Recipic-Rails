class OmniauthCallbacksController < Devise::OmniauthCallbacksController

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
