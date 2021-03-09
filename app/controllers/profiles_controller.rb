class ProfilesController < ApplicationController

    def show
        @user = User.find(params[:id])
        profile = Profile.find(@user.id)
        @user_products = @user.products
        @profile = @user.profile
    end

end
