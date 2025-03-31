require Rails.root.join("app/containers/import")
require Rails.root.join("app/containers/container")
require Rails.root.join("app/domain/repositories/todo_repository")
require Rails.root.join("app/infrastructure/repositories/active_record_todo_repository")
require Rails.root.join("app/application/use_cases/create_todo")
require Rails.root.join("app/application/use_cases/list_todos")
require Rails.root.join("app/application/use_cases/update_todo")
require Rails.root.join("app/application/use_cases/delete_todo")

Container.register("todo_repository", -> { ActiveRecordTodoRepository.new })
Container.register("create_todo", -> { CreateTodo.new })
Container.register("list_todos", -> {
  ListTodos.new(todo_repository: Container.resolve("todo_repository"))
})
Container.register("update_todo", -> {
  UpdateTodo.new(todo_repository: Container.resolve("todo_repository"))
})
Container.register("delete_todo", -> {
  DeleteTodo.new(todo_repository: Container.resolve("todo_repository"))
})