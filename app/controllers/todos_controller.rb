class TodosController < ApplicationController
    wrap_parameters format: []
    before_action :session_expired?

    def create
        todo = user.todos.create(todo_params)
        if todo.valid?
            app_response(status: :created, data: todo)
        else
            app_response(status: :unprocessable_entity, data: todo.errors, message: 'failed')
        end
    end

    private

    def todo_params
        params.permit(:title, :description, :status, :priority)
    end
end
