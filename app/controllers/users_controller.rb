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
        
        #@user = User.find(params[:id])
        #profile = Profile.find(@user.id) 
        #@user_products = @user.products
        #@profile = @user.profile
    end

    def edit
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
              format.html {redirect_to @user, notice: "user was successfully updated." }
              format.json { render :show, status: :ok, location: @user }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        respond_to do |format|
            format.html { redirect_to root_url, notice: 'User deleted!'}
            format.json { head :no_content }
          end
    end



    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username)
    end

    def set_form_vars
        @users = User.all
    end

end
