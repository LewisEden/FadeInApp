Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects
  root 'projects#index'

  get 'user/:user_name', to: 'profiles#show', as: :profile
  get 'user/:user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch 'user/:user_name/edit', to: 'profiles#update', as: :update_profile
  
  get 'projects/:project_id/join/:request_id', to: 'requests#update', as: :request_join
  get 'projects/:id/request', to: 'requests#new', as: :request_request
  post 'projects/:id/request', to: 'requests#create'
  get 'notifications', to: 'requests#show', as: :request_view
  get 'projects/:project_id/destroy/:request_id', to: 'requests#destroy', as: :request_destroy
  
  resources :chat_rooms, only: [:new, :create, :show, :index, :destroy]
  
  resources :challenges
  
  get 'challenges/:id/enter', to: 'user_challenges#new', as: :user_challenge_new
  
  mount ActionCable.server => '/cable'
  
  post 'projects/remove/:project_id/:user_id', to: 'projects#removeuser', as: :remove_user
end