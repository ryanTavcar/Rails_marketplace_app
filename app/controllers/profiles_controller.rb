class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_form_vars, only: [:new, :edit]


    def index
        @profiles = Profile.all
    end

    def new
    end
    
    def create
    end


    def show
        @profile = Profile.find(params[:id]) # profile id: 2
        @user_id = @profile.user_id  # user id: 12
        @user = User.find(@user_id) # Find user record from profile record
        @user_products = @user.products
    end

    def edit
    end


    private

    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :username)
    end

    def set_form_vars
        @users = User.all
    end
end