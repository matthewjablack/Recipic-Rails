class Api::V1::RecipesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :check_authentication

  # include Serializers::V1::ItemsSerializer

  # Just skip the authentication for now
  # before_filter :authenticate_user!

  respond_to :json

  def index
    if params[:term]
      @recipes = Recipe.where("lower(name) LIKE lower(?)", "%#{params[:term]}%").page(params[:page]).per(params[:page_limit])
    else
      @recipes = Recipe.all.page(params[:page]).per(params[:page_limit])
    end
    render :status => 200,
               :json => { :success => true,
                          :info => "Received recipes",
                          :data => {recipes: @recipes} }
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