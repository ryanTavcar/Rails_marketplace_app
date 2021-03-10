class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_profile, only: [:show, :edit, :update, :destroy]
    before_action :set_form_vars, only: [:new, :edit]

    respond_to :html

    # ISSUE: Having to create a profile via rails console
    # I want to create a profile upon signup after being
    # redirected to profile form.

    def index
        @profiles = Profile.all
    end

    def new
        @profile = current_user.build_profile
    end
    
    def create
        @profile = current_user.build_profile(profile_params)
        if @profile.save
          flash[:success] = "Profile saved"
          redirect_to profiles_path
        else
          flash[:error] = "Error"
          render :new
        end
    end


    def show
        @profile = Profile.find(params[:id])
    end

    def edit
        @profile = current_user.profile #.find(params[:id])
    end

    def update
        @profile = current_user.profile #.find(params[:id])
        if @profile.update(profile_params)
            flash[:success] = "Successfully updated"    # Optional
            redirect_to profile_path(current_user.profile.id)
        else
            flash[:error] = "Error"       # Optional
            render :edit
        end
    end

    def destroy
    end

    private

    def profile_params
        params.require(:profile).permit(:first_name, :last_name, users_attributes: [:id, :username])
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