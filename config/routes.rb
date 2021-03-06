Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :commit_messages, only: [:index]
      resources :commit_timelines, only: [:index]
      resources :languages, only: [:index]
      resources :users, only: [:index]
      resources :community, only: [:index]
      resources :messaging, only: [:create]
      resources :repository_timeline, only: [:index]
    end
  end
end
