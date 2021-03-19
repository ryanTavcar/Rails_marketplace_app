class HomeController < ApplicationController

    # Find all products that have not been bought
    def index
        @products = Product.all
    end

    def payment_success
        pp params
        product_id = params[:productId]
        @product = Product.find(product_id)
        #@purchase = Order.find_by_product_id(product_id)
        @purchase = Order.find_by_product_id(@product)
    end
    
end
