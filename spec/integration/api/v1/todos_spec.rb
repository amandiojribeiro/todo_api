require 'swagger_helper'

RSpec.describe 'api/v1/todos', type: :request do

  path '/api/v1/todos' do
    post('create todo') do
      tags 'Todos'
      consumes 'application/json'
      produces 'application/json'
      security [ bearerAuth: [] ]

      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          todo: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              status: { type: :string },
              due_date: { type: :string, format: :date }
            },
            required: %w[title description status due_date]
          }
        },
        required: ['todo']
      }

      response(201, 'created') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            description: { type: :string },
            status: { type: :string },
            due_date: { type: :string, format: :date },
            user_id: { type: :integer },
            created_at: { type: :string, format: :date_time },
            updated_at: { type: :string, format: :date_time }
          },
          required: %w[id title description status due_date user_id created_at updated_at]

        let(:Authorization) { "Bearer #{create(:user).generate_jwt}" }

        let(:todo) do
          {
            todo: {
              title: 'New Swagger ToDo',
              description: 'Spec this out',
              status: 'in progress',
              due_date: '2025-05-01'
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/todos' do
    get('list todos') do
      tags 'Todos'
      produces 'application/json'
      security [ bearerAuth: [] ]
  
      parameter name: :status, in: :query, type: :string, required: false
      parameter name: :due_date_from, in: :query, type: :string, format: :date, required: false
      parameter name: :due_date_to, in: :query, type: :string, format: :date, required: false
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
  
      response(200, 'successful') do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            description: { type: :string },
            status: { type: :string },
            due_date: { type: :string, format: :date },
            user_id: { type: :integer },
            created_at: { type: :string, format: :date_time },
            updated_at: { type: :string, format: :date_time }
          }
        }
  
        let(:Authorization) { "Bearer #{create(:user).generate_jwt}" }
  
        run_test!
      end
    end
  end

  path '/api/v1/todos/{id}' do
    put('update todo') do
      tags 'Todos'
      consumes 'application/json'
      produces 'application/json'
      security [ bearerAuth: [] ]
  
      parameter name: :id, in: :path, type: :integer
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          status: { type: :string },
          due_date: { type: :string, format: :date }
        }
      }
  
      response(200, 'updated') do
        let(:id) { 1 }
        let(:Authorization) { "Bearer #{create(:user).generate_jwt}" }
  
        let(:todo) do
          {
            todo: {
              title: 'Updated title',
              status: 'completed'
            }
          }
        end
  
        run_test!
      end
    end
  end

  path '/api/v1/todos/{id}' do
    delete('delete todo') do
      tags 'Todos'
      security [ bearerAuth: [] ]
      parameter name: :id, in: :path, type: :integer
  
      response(204, 'deleted') do
        let(:id) { 1 }
        let(:Authorization) { "Bearer #{create(:user).generate_jwt}" }
        run_test!
      end
    end
  end
end