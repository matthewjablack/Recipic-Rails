class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :omniauthable,:validatable, :registerable


	has_many :authorizations, dependent: :destroy


	before_save :ensure_authentication_token



  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end



  def self.from_omniauth(auth, current_user)
  	if auth.provider == "facebook"
  		graph = Koala::Facebook::API.new(auth.credentials.token)
			facebook_data = graph.get_object("me",  {fields: ['id', 'name','email', 'first_name', 'last_name', 'friends', 'name_format', 'birthday']})
			auth.info.merge! :email=>facebook_data['email']
			auth.info.merge! :first_name=>facebook_data['first_name']
			auth.info.merge! :last_name=>facebook_data['last_name']
			# auth.info.merge! :name_format=>facebook_data['name_format']
			# auth.info.merge! :birthday=> Date.strptime(facebook_data['birthday'], '%m/%d/%Y').to_time
  	end
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
				user = User.new
				user.password = Devise.friendly_token[0,10]
				user.name = auth.info.name
				user.email = auth.info.email
        # user.confirmed_at = Time.now
       	user.first_name = auth["info"]["first_name"]
        user.last_name = auth["info"]["last_name"]
				# if auth.provider == "facebook"
				# 	user.name_format = auth["info"]["name_format"]
				# 	user.birthday = auth["info"]["birthday"]
				# end
				user.save
			end
			authorization.user_id = user.id
			authorization.save

		end
		authorization.user
  end


  private 


  	def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end



end
