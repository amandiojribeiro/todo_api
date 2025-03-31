class TodoRepository
  def all_by_user(user_id:, filters: {}, pagination: {}); raise NotImplementedError; end
  def all(filters: {}, pagination: {}); raise NotImplementedError; end
  def find(id); raise NotImplementedError; end
  def create(attrs); raise NotImplementedError; end
  def update(id, attrs); raise NotImplementedError; end
  def delete(id); raise NotImplementedError; end
  def paginated_all(filters:, pagination: {}); raise NotImplementedError; end
  def paginated_all_by_user(user_id:, filters:, pagination: {}); raise NotImplementedError; end
end