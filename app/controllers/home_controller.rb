class HomeController < ApplicationController

    # Find all products that have not been bought
    def index
        @products = Product.order(created_at: :desc).eager_load(:user, :likes, :material, :categories).with_attached_picture
    end

    def payment_success
        pp params
        product_id = params[:productId]
        @product = Product.find(product_id)
        @purchase = Order.find_by_product_id(@product)
    end
    
end
