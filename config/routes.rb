Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users,
             controllers: {
               sessions: 'users/sessions'
             }

  # Example protected route
  namespace :api do
    namespace :v1 do
      resources :todos, only: [:create, :index, :update, :destroy]
    end
  end
end
