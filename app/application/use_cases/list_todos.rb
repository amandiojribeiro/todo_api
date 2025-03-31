require Rails.root.join("app/containers/import")

class ListTodos
  include Import["todo_repository"]

  def call(user:, filters: {}, pagination: {})
    ActiveSupport::Notifications.instrument("todo.list") do
        if user.admin?
          todo_repository.paginated_all(filters: filters, pagination: pagination)
        else
          todo_repository.paginated_all_by_user(user_id: user.id, filters: filters, pagination: pagination)
        end
      end
    end
end