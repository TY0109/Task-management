Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  post   '/guest_login', to: 'guest_sessions#create'
  post   '/guest_admin_login', to: 'guest_admin_sessions#create'
  
  resources :users do
    resources :tasks
  end
end
