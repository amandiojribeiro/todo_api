# config/initializers/observability.rb
ActiveSupport::Notifications.subscribe("todo.create") do |name, start, finish, id, payload|
  Rails.logger.info("[OBSERVABILITY] #{name} - Duration: #{(finish - start) * 1000}ms, Payload: #{payload}")
end

ActiveSupport::Notifications.subscribe("todo.update") do |name, start, finish, id, payload|
  Rails.logger.info("[OBSERVABILITY] #{name} - Duration: #{(finish - start) * 1000}ms, Payload: #{payload}")
end

ActiveSupport::Notifications.subscribe("todo.delete") do |name, start, finish, id, payload|
  Rails.logger.info("[OBSERVABILITY] #{name} - Duration: #{(finish - start) * 1000}ms, Payload: #{payload}")
end

ActiveSupport::Notifications.subscribe("todo.list") do |name, start, finish, id, payload|
  Rails.logger.info("[OBSERVABILITY] #{name} - Duration: #{(finish - start) * 1000}ms, Payload: #{payload}")
end