class Api::V1::ImagesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :check_authentication

  # include Serializers::V1::ItemsSerializer

  # Just skip the authentication for now
  # before_filter :authenticate_user!

  respond_to :json



  def photo_identify
    conn = Faraday.new(:url => 'https://api.clarifai.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    # topicString = "/topics/" + @organization.url


    response = conn.post do |req|
      req.url '/v2/models/bd367be194cf45149e75f01d59f77ba7/outputs'
      req.headers['Accept'] = 'application/json'
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = 'Bearer neAwUiUHss06ZPAxpcEyoTZrkOWiU4'

      req.body = '{"inputs": [{"data": {"image": {"url": "https://samples.clarifai.com/food.jpg"}}}]}'
    end
  end

  private


    def check_authentication
       if User.where(authentication_token: params[:auth_token]).count == 1
        @user = User.where(authentication_token: params[:auth_token]).first
       else
        render :status => 401,
               :json => { :success => false,
                          :info => "Authentication failed",
                          :data => {} }
       end

   end

end
