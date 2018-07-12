class UsersController < ApplicationController
    
    def show
        if(requires_login && authorized?(params[:id]))
            @user = User.find(params[:id])
            render json: {user: @user.stock_symbols}
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

    def update
        if(requires_login && authorized?(params[:id]))
            if  params[:type] == 'removeFavorite'
                user = User.find(params[:id])
                stock = StockSymbol.find_by(stock_symbol: params[:symbol])
                user.stock_symbols.delete(stock)
                # Favorite.where(user_id: user.id).where(stock_symbol)
                # byebug
                # stock = user.stock_symbols.where(stock_symbol: params[:symbol])
                render json: {message: "Gone"}
            else
                user = User.find(params[:id])
                stock = StockSymbol.find_by(stock_symbol: params[:symbolId])
                user.stock_symbols << stock
                render json: stock
            end
        else
            render json: {Err: "user.errors"}
        end
    end

  

    

end