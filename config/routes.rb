Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resources :commit_messages, only: [:index]
      resources :languages, only: [:index]
    end
  end
end
