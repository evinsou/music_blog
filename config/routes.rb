Romans::Application.routes.draw do

  resources :songs
  resources :feedbacks, except: [:new, :show]  do
    put :publish, on: :member
    get :not_published, on: :collection
  end

  get '/contacts' => 'messages#new', as: 'contacts'
  resources :messages, :disks, except: :show

  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"
  get "sign_up" => "users#new", as: "sign_up"
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  get '/welcome' => "welcome#index", as: 'welcome'

  root to: 'pages#show', id: 'main_page'
end
