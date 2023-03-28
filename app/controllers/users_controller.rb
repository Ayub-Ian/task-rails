class UsersController < ApplicationController
    wrap_parameters format: []
    before_action :session_expired?, only: [:check_login_status]

    def register
        user = User.create!(user_params)
        if user.valid? 
            save_user(user.id)
            app_response(message: "You've been registered succesfully", status: :created, data: user)
        else
            app_response(message: "Something went wrong with your registration", status: :unprocessable_entity, data: users.errors)
        end
    end

    def login
        sql = "username = :username OR email = :email"
        user = User.where(sql, {username: user_params[:username], email: user_params[:email] }).first
        if user&.authenticate(user_params[:password])
            save_user(user.id)
            token = encode user.id, user.email
            app_response(message: 'Login was successful', status: :ok, data:{ user: user, token: token})
        else
            app_response(message: 'Invalid username or password', status: :unauthorized)
        end
    end

    def logout
        remove_user
        app_response(message: 'Logout successful')
    end

    def check_login_status
        app_response(message: 'success', status: :ok)
    end

    private 
    def user_params
        params.permit(:username, :email, :password)
    end
end
