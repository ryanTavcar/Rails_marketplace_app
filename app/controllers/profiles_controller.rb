class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_profile, only: [:show, :edit, :update, :destroy]
    before_action :set_form_vars, only: [:new, :edit]

    # ISSUE: Having to create a profile via rails console
    # I want to create a profile upon signup after being
    # redirected to profile form.

    def index
    end

    def new
        @profile = current_user.build_profile
    end
    
    def create
        @profile = current_user.create_profile(first_name: profile_params["first_name"], last_name: profile_params["last_name"], biography: profile_params["biography"], picture: profile_params[:picture])
        current_user.username = profile_params["user_attributes"]["username"]
        if @profile.save && current_user.save
          flash[:success] = "Profile saved"
          redirect_to @profile
        else
          flash[:error] = "Error"
          render :new
        end
    end


    def show
        @profile = Profile.find(params[:id])
        liked_products
    end

    def edit
        @profile = current_user.profile #.find(params[:id])
    end

    def update
       @profile = current_user.profile #.find(params[:id])
       if @profile.update(picture: profile_params[:picture], first_name: profile_params["first_name"], last_name: profile_params["last_name"]) && current_user.update(username: profile_params["user_attributes"]["username"])
            flash[:success] = "Successfully updated"    # Optional
            redirect_to @profile
        else
            flash[:error] = "Error"       # Optional
            render :edit
        end
    end

    def destroy
    end

    def liked_products
        @user = User.find(params[:id])
        @liked_products = @user.likes.eager_load(:product)
    end

    def settings
        @profile = Profile.find(params[:id])
    end

    private

    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :biography, :picture, user_attributes: [:id, :username])
    end


    def set_form_vars
        @users = User.all
    end

    def find_profile
        if Profile.exists?(current_user.id)
            @profile = Profile.find(params[:id])
            @user_id = @profile.user_id 
        end
    end

end