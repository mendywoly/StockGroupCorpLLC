class UsersController < ApplicationController
    
    def show
        if(requires_login)
            @user = User.find(params[:id])
            payload = decode_token

            currentUser = User.find_by(id: payload[0]['id'])
                if currentUser.id === @user.id
                    render json: {user: @user, pay:payload}
                else
                    render json: payload
                end
        else
            render json: {message: "No!", p: payload}
        end
    end

    def create
        # byebug
        user = User.create(name: params[:name], username: params[:username], password: params[:password])
        if user.valid?
            render json: {
                user: user,
                token: get_token(payload( user.name, user.id ))
            }
        else
            render json: user.errors
        end
                
    end

end