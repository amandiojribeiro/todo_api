ActiveSupport::Notifications.subscribe("todo.create") do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  Rails.logger.info(
    "[OBSERVABILITY] Created todo",
    duration: "#{event.duration.round(2)}ms",
    payload: event.payload
  )
end

ActiveSupport::Notifications.subscribe("todo.list") do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  Rails.logger.info(
    "[OBSERVABILITY] Listed todos",
    duration: "#{event.duration.round(2)}ms",
    payload: event.payload
  )
end

ActiveSupport::Notifications.subscribe("todo.update") do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  Rails.logger.info(
    "[OBSERVABILITY] update todos",
    duration: "#{event.duration.round(2)}ms",
    payload: event.payload
  )
end

ActiveSupport::Notifications.subscribe("todo.delete") do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  Rails.logger.info(
    "[OBSERVABILITY] deleted todos",
    duration: "#{event.duration.round(2)}ms",
    payload: event.payload
  )
end