class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :set_product, only: %i[ show ]
    before_action :set_user_product, only: [ :update, :edit, :destroy]
    before_action :set_form_vars, only: [:new, :edit]

    # GET method to get all products from database
    def index
        @products = Product.all
    end

    # GET method to get a product by id
    def show
        @product = Product.find(params[:id])
    end

    # GET method for the new product form
    def new
        @product = Product.new
        @material = @product.material_id
    end

    # POST method for processing form data
    def create
        @product = Product.new(product_params)
        respond_to do |format|
            if @product.save
              format.html { redirect_to @product, notice: 'Product added!'}
              format.json { render :show, status: :created, location: @product }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end

    # GET method for editing a product based on id
    def edit
        @product = Product.find(params[:id])
    end

    # PUT/PATCH method for updating in database a pruduct based on id
    def update
        @product = Product.find(params[:id])
        respond_to do |format|
            if @product.save
              format.html { redirect_to @product, notice: 'Product updated!'}
              format.json { render :show, status: :created, location: @product }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE method for deleting a product from the database
    def destroy
        @product = Product.find(params[:id])

        respond_to do |format|
            format.html { redirect_to products_url, flash[:notice] = 'Product deleted!'}
            format.json { head :no_content }
          end
    end

    private

    # we used strong parameters for the validation of params
    def product_params
        params.require(:product).permit(:name, :like, :description, :price, :material_id, :user_id)
    end

    def set_user_product
        @product = current_user.products.find_by_id(params[:id])
        if @product == nil
          flash[:alert] = "you don't have permission to do that!"
          redirect_to(product_path)
        end
    end

    def set_product
        @product = Product.find(params[:id])
    end

    def set_form_vars
        @categories = Category.all
        #@conditions = Product.conditions.keys
        @materials = Material.all
      end
    
end

