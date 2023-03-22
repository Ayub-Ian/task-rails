class UsersController < ApplicationController
    def register
        user = User.create!(register_params)
        if user.valid? 
            app_response(message: "You've been registered succesfully", status: :created, data: user)
        else
            app_response(message: "Something went wrong with your registration", status: :unprocessable_entity, data: users.errors)
        end
    end

    private 
    def register_params
        params.permit(:username, :email, :password)
    end
end
