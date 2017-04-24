class Api::V1::ItemsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

	before_filter :check_authentication

  # include Serializers::V1::ItemsSerializer

  # Just skip the authentication for now
  # before_filter :authenticate_user!

  respond_to :json

  def index
  	if params[:term]
  		@items = Item.where("lower(name) LIKE lower(?)", "%#{params[:term]}%")
  	else
  		@items = Item.all.page(params[:page]).per(params[:page_limit])
  	end

    if @items.count == 0
      render :status => 200,
           :json => { :items => [{id: 0, name: params[:term]}] }
    else
      render :status => 200,
           :json => { :items => @items }
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