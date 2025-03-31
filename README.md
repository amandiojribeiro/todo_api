# 📝 ToDo API

A clean, scalable Ruby on Rails API for managing todos using Onion Architecture, Dependency Injection, and modern Rails best practices. Built as a demo to demonstrate architecture, testing, and production-readiness features.

---

## 🚀 Features

- ✅ Onion Architecture (clean separation of concerns)
- ✅ JWT Authentication with Devise + devise-jwt
- ✅ CRUD for todos
- ✅ Filtering: status, due date, title, user (admin)
- ✅ Pagination support
- ✅ Role-based access (`admin` vs regular user)
- ✅ API documentation with Swagger (Rswag)
- ✅ Rate Limiting with `rack-attack`
- ✅ Observability with `ActiveSupport::Notifications`
- ✅ Logging (Rails built-in + custom logs)

---

## ⚙️ Setup

```bash
# Clone and setup
git clone https://github.com/your-org/todo_api.git
cd todo_api
bundle install

# Setup database
rails db:create db:migrate db:seed

# Run specs
bundle exec rspec

# Run app
rails server
```

---

## 🔐 Authentication

- Uses `devise` with `devise-jwt`
- Login via `/users/sign_in`
- Use the received JWT token in `Authorization: Bearer <token>` header for all requests

---

## 📄 API Documentation

Rswag generates OpenAPI docs from specs.

- Visit: `http://localhost:3000/api-docs`

---

## 🧠 Architecture

**Layered (Onion) Structure:**
```
app/
├── application/         # Use cases
├── domain/              # Business entities (models, interfaces)
├── infrastructure/      # ActiveRecord + IO implementations
├── interfaces/          # Web controllers, serializers
└── containers/          # DI (dry-container)
```

---

## 📈 Observability & Logging

- All `create`, `update`, and `delete` operations are logged with user context
- Events instrumented via `ActiveSupport::Notifications`
- TODOs creation: `instrument("todo.create")`
- Easily pluggable into NewRelic, DataDog, or custom monitoring

---

## 🔒 Rate Limiting

`rack-attack` is configured to:
- Limit login attempts
- Throttle API requests to prevent abuse

---

## 🔬 Testing

- RSpec for unit & request specs
- Swagger-powered request specs for auto-generating OpenAPI docs
- FactoryBot for test data

---

## 📦 Future Improvements

- Background jobs (Sidekiq)
- Webhooks & notifications
- Export/reporting system
- Admin dashboard

---

## 🧑‍💻 Author

Made with 🧠 and 💎 by Amândio.