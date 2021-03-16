module LikesHelper

    def pre_like
        pre_like = @product.likes.find { |like| like.user_id == current_user.id}
    end
end
