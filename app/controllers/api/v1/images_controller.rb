class Api::V1::ImagesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :check_authentication

  # include Serializers::V1::ItemsSerializer

  # Just skip the authentication for now
  # before_filter :authenticate_user!

  respond_to :json




  def photo_identify
    #binding.pry

    @image = Image.new(image: decode_base64_image(params[:image]))
    @image.save!

    #binding.pry

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
      req.headers['Authorization'] = 'Bearer BUBTeOLPZpXEqN5qJHX3DP9M1qcUxp'

      req.body = '{"inputs": [{"data": {"image": {"url":"http://recipic.net'+ @image.image_url + '"}}}]}'
      #req.body = '{"inputs": [{"data": {"image": {"url":"http://www.jqueryscript.net/images/Simplest-Responsive-jQuery-Image-Lightbox-Plugin-simple-lightbox.jpg"}}}]}'

    end
    json = JSON.parse(response.body.to_s)

    Rails.logger.info "http://recipic.net" + @image.image_url

    Rails.logger.info "Serialize DATA: " + json["outputs"][0]["data"]["concepts"].to_s

    render :status => 200,
           :json => { :success => true,
                      :info => "Success",
                      :data => {:image_id => @image.id, :response => serialize_items( json["outputs"][0]["data"]["concepts"])} }

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
   def decode_base64_image(encoded_file)

       decoded_file = Base64.decode64(encoded_file)

       file = Tempfile.new(['image','.jpg'])
       file.binmode
       file.write decoded_file
       return file
   end


   def serialize_items(items)
     items.map do |item|
       {
         name: item["name"],
         value: item["value"]
       }
     end
   end

end
