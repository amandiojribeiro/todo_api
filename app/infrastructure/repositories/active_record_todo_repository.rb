class ActiveRecordTodoRepository < TodoRepository
  def all_by_user(user_id:, filters: {})
    scope = Todo.where(user_id: user_id)
    scope = scope.where(status: filters[:status]) if filters[:status]
    if filters[:due_from] && filters[:due_to]
      scope = scope.where(due_date: filters[:due_from]..filters[:due_to])
    end
    scope.order(due_date: :asc)
  end

  def all(filters: {}, pagination: {})
    scope = Todo.all
    scope = apply_filters(scope, filters)
    scope = apply_pagination(scope, pagination)
    scope
  end

  def find(id)
    Todo.find(id)
  end

  def create(attrs)
    Todo.create!(attrs)
  end

  def update(id, attrs)
    todo = Todo.find(id)
    todo.update!(attrs)
    todo
  end

  def delete(id)
    Todo.find(id).destroy!
  end
  
  def all(filters: {}, pagination: {})
    scope = Todo.all
    scope = apply_filters(scope, filters)
    apply_pagination(scope, pagination)
  end

  def all_by_user(user_id:, filters: {}, pagination: {})
    scope = Todo.where(user_id: user_id)
    scope = apply_filters(scope, filters)
    apply_pagination(scope, pagination)
  end

  def paginated_all_by_user(user_id:, filters:, pagination: {})
    scope = Todo.where(user_id: user_id)

    scope = apply_filters(scope, filters)
    total = scope.count

    records = scope
      .order(created_at: :desc)
      .limit(pagination[:per_page])
      .offset((pagination[:page] - 1) * pagination[:per_page])

    { records:, total: }
  end

  def paginated_all(filters:, pagination: {})
    scope = apply_filters(Todo.all, filters)
    total = scope.count

    records = scope
      .order(created_at: :desc)
      .limit(pagination[:per_page])
      .offset((pagination[:page] - 1) * pagination[:per_page])

    { records:, total: }
  end

  private

  def apply_filters(scope, filters)
    scope = scope.where(status: filters[:status]) if filters[:status]
    scope = scope.where("due_date >= ?", filters[:due_from]) if filters[:due_from]
    scope = scope.where("due_date <= ?", filters[:due_to]) if filters[:due_to]
    scope = scope.where("title ILIKE ?", "%#{filters[:title]}%") if filters[:title]
    scope = scope.where(user_id: filters[:user_id]) if filters[:user_id]
    scope
  end

  def apply_pagination(scope, pagination)
    page = pagination[:page].to_i > 0 ? pagination[:page].to_i : 1
    per_page = pagination[:per_page].to_i > 0 ? pagination[:per_page].to_i : 10
    scope.offset((page - 1) * per_page).limit(per_page)
  end
end