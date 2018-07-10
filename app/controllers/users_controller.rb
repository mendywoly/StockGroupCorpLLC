class UsersController < ApplicationController
    
    def show
        if(requires_login)
            @user = User.find(params[:id])
            render json: @user
        else
            render json: {message: "No!"}
        end
    end

end