require Rails.root.join("app/containers/import")

class DeleteTodo
  include Import["todo_repository"]

  def call(user:, id:)
    ActiveSupport::Notifications.instrument("todo.delete") do
        todo = todo_repository.find(id)
        unless user.admin? || todo.user_id == user.id
          raise ActiveRecord::RecordNotFound
        end
      
        todo_repository.delete(id)
      end
    end
end