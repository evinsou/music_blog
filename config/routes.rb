Romans::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :songs, :disks, :only => [:index,  :show]
  resources :feedbacks, :messages, :only => [:new, :create]

  get '/contacts' => 'messages#new', as: 'contacts'
  get '/anons' => 'pages#show', id: 'announcement'

  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"
  get "sign_up" => "users#new", as: "sign_up"
  resources :users, only: [:new, :create]
  resource :session
  get 'admin_menu' => "welcome#index", as: 'admin_menu'

  get '/:id' => 'high_voltage/pages#show', :as => :static
  root to: 'pages#show', id: 'main_page'
end
