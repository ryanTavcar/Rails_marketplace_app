class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
              format.html { redirect_to @user, notice: 'Profile added!'}
              format.json { render :show, status: :created, location: @user }
            else
              format.html { render :new }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def show
        @user = User.find(params[:id])
        profile = Profile.find(@user.id)
        @user_products = @user.products
        @profile = @user.profile
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username)
    end

    def set_form_vars
        @users = User.all
    end

end
