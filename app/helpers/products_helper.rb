module ProductsHelper

    def purchased_false(product)
      current_user && product.purchased == false
    end

    def format_likes(product)
      product.likes.count == 1 ? 'Like' : 'Likes'
    end

end
