module ApplicationHelper

    def users_own_profile(x)
        current_user && current_user.id == x.user.id
    end
end
