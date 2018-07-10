class SessionsController < ApplicationController

    def create
        @user = User.find_by(username: params["username"])
        if(@user && @user.authenticate(params["password"]))
            render json: {
                username: @user.username,
                id: @user.id,
                token: get_token(payload(@user.username, @user.id))
              }
        else
            render json: { err: 'wrong password'}, status: :unauthorized
        end
    end


end