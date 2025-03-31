class CreateTodo
  include Import["todo_repository"]

  def call(user:, params:)
    # Basic validation
    raise ArgumentError, "Title is required" if params[:title].blank?

    # Prepare attributes for persistence
    attrs = {
      title:       params[:title],
      description: params[:description],
      status:      params[:status] || "pending",
      due_date:    params[:due_date],
      user_id:     user.id
    }

    #Observability 
    ActiveSupport::Notifications.instrument("todo.create") do
      todo_repository.create(attrs)
    end
  end
end