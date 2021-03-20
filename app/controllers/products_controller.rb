class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_product, only: %i[ show ]
  before_action :set_user_product, only: [ :update, :edit, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  # Find random records in Product table for explore page.
  def index
    @products = Product.order("RANDOM()").eager_load(:user, :likes, :material, :categories).with_attached_picture
  end

  # GET method to get a product by id from set_product and Stripe
  def show
      stripe_session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          client_reference_id: current_user ? current_user.id : nil, 
          customer_email: current_user ? current_user.email : nil,
          line_items: [{
            name: @product.name,
            description: @product.description,
            amount: @product.price * 100,
            currency: 'aud',
            quantity: 1
          }],
          payment_intent_data: {
            metadata: {
              product_id: @product.id,
              user_id: current_user ? current_user.id : nil
            }
          },
          success_url: "#{root_url}payments/success?productId=#{@product.id}",
          cancel_url: "#{root_url}products"
        )
        @session_id = stripe_session.id
  end

  # GET method for the new product form
  def new
      @product = current_user.products.build
  end

  # POST method for processing form data
  def create
      @product = current_user.products.build(product_params)
      respond_to do |format|
        if @product.save
            format.html { redirect_to @product, notice: 'Product added!'}
            format.json { render :show, status: :created, location: @product }
          else
            format.html { render :new }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
      end
  end

  # GET method for editing a product based on id
  def edit
  end

  # PUT/PATCH method for updating in database a pruduct based on id
  def update
      respond_to do |format|
          if @product.update(product_params)
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
      @product.destroy
      respond_to do |format|
          format.html { redirect_to products_url, notice: 'Product deleted!'}
          format.json { head :no_content }
        end
  end

  def settings
    @product = Product.find(params[:id])
  end

  private

  # we used strong parameters for the validation of params
  def product_params
      params.require(:product).permit(:name, :like, :description, :price, :material_id, :user_id, :picture, :file, category_ids: [])
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

  # Set form variables
  def set_form_vars
      @categories = Category.all
      @materials = Material.all
  end
    
end

