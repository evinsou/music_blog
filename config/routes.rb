Romans::Application.routes.draw do

  resources :video_records, :photos, :only => :index
  resources :songs, :disks, :titov_songs, :only => [:index,  :show]
  resources :feedbacks, :only => [:index, :create] do
    member do
      put 'publish'
    end
  end
  resources :messages, :only => [:index, :create]

  get '/contacts' => 'messages#new', as: 'contacts'
  get '/anons' => 'pages#show', id: 'announcement'

  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"
  get "sign_up" => "users#new", as: "sign_up"
  resources :users, only: [:new, :create]
  resource :session

  get '/:id' => 'high_voltage/pages#show', :as => :static
  root to: 'pages#show', id: 'main_page'

#  ActiveAdmin.routes(self)
#  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
