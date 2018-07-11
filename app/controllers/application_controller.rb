class ApplicationController < ActionController::API

    def secret_key
        ENV['SECRET_KEY']  
    end


    def payload(name, id)
        { name: name, id: id }
    end

    def get_token(payload)
        JWT.encode payload, secret_key(), 'HS256'
    end

    def valid_token?
        !!decode_token
    end

    def authorization_token
        request.headers['Authorization']
    end

    def decode_token
        begin
            JWT.decode authorization_token(), secret_key(), true, { algorithm: 'HS256' }
        rescue JWT::VerificationError, JWT::DecodeError
            nil
        end
    end

    def requires_login
        if  !valid_token?
            false
        else
            true
        end
    end

    def authorized?(id)
        payload = decode_token
        # byebug
        return payload[0]['id'] == id.to_i 
    end

end
