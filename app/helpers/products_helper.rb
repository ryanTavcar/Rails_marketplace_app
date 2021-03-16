module ProductsHelper

    def format_likes(product)
      product.likes.count == 1 ? 'Like' : 'Likes'
    end

end
