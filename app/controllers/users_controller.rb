class UsersController < ApplicationController
    
    def show
        if(requires_login)
            @user = User.find(params[:id])
            payload = decode_token
            h = User.find_by(name: payload[0]['name'])
                if h.id === @user.id
                render json: @user 
                else
                    render json: {message: "No!"}
                end
        else
            render json: {message: "No!"}
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