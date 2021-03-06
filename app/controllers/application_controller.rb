class ApplicationController < ActionController::API
    before_action :logged_in?

    def encode_token(payload)
        JWT.encode(payload, "AdaEarTraining")
    end

    def logged_in?
        headers = request.headers["Authorization"]
        # byebug
        if headers !="Bearer undefined"
            # byebug
            token = headers.split(" ")[1]
        end

        begin
            user_id = JWT.decode(token, "AdaEarTraining")[0]["user_id"]
            user = User.find(user_id)
            @logged_in_user = user
        rescue => exception
            user = nil
        end

        render json: {error: "Please log in or sign up to play the games"} unless user
    end

    # def current_user
    #     headers = request.headers["Authorization"]
    #     token = headers.split(" ")[1]

    #     begin
    #         user_id = JWT.decode(token, "AdaEarTraining")[0]["user_id"]
    #         user = User.find(user_id)
    #     rescue => exception
    #         user = nil
    #     end
    #     if user
    #         return user
    #     else
    #         # render json: {error: "Please log in or sign up to play the games"}
    #         return nil
    #     end
    # end

end
