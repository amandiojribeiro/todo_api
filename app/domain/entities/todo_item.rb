class TodoItem
  attr_accessor :id, :title, :description, :status, :due_date, :user_id

  def initialize(id:, title:, description: nil, status: "pending", due_date: nil, user_id:)
    @id = id
    @title = title
    @description = description
    @status = status
    @due_date = due_date
    @user_id = user_id
  end
end