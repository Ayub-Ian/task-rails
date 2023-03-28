class TodosController < ApplicationController
    wrap_parameters format: []
    # before_action :session_expired?
    before_action :verify_auth

    def create
        todo = user.todos.create(todo_params)
        if todo.valid?
            app_response(status: :created, data: todo)
        else
            app_response(status: :unprocessable_entity, data: todo.errors, message: 'failed')
        end
    end

    def update
        todo = user.todos.find(params[:id]).update(todo_params)
        if todo
            app_response(data: { info: 'updated todo successfully' })
        else
            app_response(message:'failed', status: :unprocessable_entity )
        end
    end

    def destroy
        todo = user.todos.find(params[:id]).destroy
        app_response(message: 'success', status: 204 , data: {info: "deleted todo successfully"})
    end

    def index
        todos = user.todos.all
        app_response(message: 'success', data: todos)
    end

    private

    def todo_params
        params.permit(:title, :description, :status, :priority)
    end


end
