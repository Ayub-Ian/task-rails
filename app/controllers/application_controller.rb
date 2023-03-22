class ApplicationController < ActionController::API
    # Custom HTTP response
    def app_response(message: 'Success', status: 200, data: nil) 
        render json: {message: message, status: status, data: data}
    end
end
