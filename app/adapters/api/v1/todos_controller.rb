module Api
  module V1
    class TodosController < ApplicationController
      before_action :authenticate_user!
      
      def destroy
        use_case = Container.resolve("delete_todo")
        use_case.call(user: current_user, id: params[:id])
        head :no_content
      end

      def update
        use_case = Container.resolve("update_todo")
      
        updated = use_case.call(
          user: current_user,
          id: params[:id],
          params: params.require(:todo).permit(:title, :description, :status, :due_date)
        )
      
        render json: updated
      end

      def index
        use_case = Container.resolve("list_todos")
      
        filters = {
          status: params[:status],
          due_from: params[:due_date_from],
          due_to: params[:due_date_to],
          title: params[:title],
          user_id: params[:user_id]
        }.compact
      
        pagination = {
          page: (params[:page] || 1).to_i,
          per_page: (params[:per_page] || 10).to_i
        }
      
        result = use_case.call(user: current_user, filters: filters, pagination: pagination)
      
        render json: {
          todos: result[:records],
          meta: {
            page: pagination[:page],
            per_page: pagination[:per_page],
            total: result[:total]
          }
        }
      end

      def create
        #Logs
        Rails.logger.info("Creating todo", user_id: current_user.id, params: params.to_unsafe_h)

        use_case = Container.resolve("create_todo")
        todo = use_case.call(user: current_user, params: todo_params)
        render json: todo, status: :created
      rescue ArgumentError => e
        #Logs
        Rails.logger.error("Todo creation failed", error: e.message)
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def todo_params
        params.require(:todo).permit(:title, :description, :status, :due_date)
      end
    end
  end
end