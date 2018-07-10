class UsersController < ApplicationController
    def initialize
        
    end

    def show
        if(requires_login)
            render json: {
                message: "login"
            }
        end
    end
end