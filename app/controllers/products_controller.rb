class ProductsController < ApplicationController

    # GET method to get all products from database
    def index
        @products = Products.all
    end

    # GET method to get a product by id
    def show
        @product = Product.find(params[:id])
    end

    # GET method for the new product form
    def new
        @product = Product.new
    end

    # POST method for processing form data
    def create
        @product = Product.new(product_params)
        if @product.save
            flash[:notice] = 'Product added!'
            redirect_to_root_path
        else
            flash[:error] = 'Failed to edit product!'
            render :new
        end
    end

    # GET method for editing a product based on id
    def edit
        @product = Product.find(params[:id])
    end

    # PUT/PATCH method for updating in database a pruduct based on id
    def update
        @product = Product.find(params[:id])
        if product.update_attributes(product_params)
            flash[:notice] = 'Product updated!'
            redirect_to_root_path
        else
            flash[:error] = 'Failed to update product!'
            render :edit
        end
    end

    # DELETE method for deleting a product from the database
    def destroy
        @product = Product.find(params[:id])
        if @product.delete
            flash[:notice] = 'Product deleted!'
            redirect_to_root_path
        else
            flash[:error] = 'Failed to delete this product!'
            render :destroy
        end
    end

    private

    # we used strong parameters for the validation of params
    def product_params
        params.require(:product).permit(:name, :like, :description, :price, :material_id, :user_id)
    end
    
end

