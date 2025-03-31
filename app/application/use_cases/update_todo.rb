require Rails.root.join("app/containers/import")

class UpdateTodo
  include Import["todo_repository"]

  def call(user:, id:, params:)
    ActiveSupport::Notifications.instrument("todo.update") do
        todo = todo_repository.find(id)
        unless user.admin? || todo.user_id == user.id
          raise ActiveRecord::RecordNotFound
        end
      
        todo_repository.update(id, params)
      end
    end
end