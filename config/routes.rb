Romans::Application.routes.draw do

  get '/profile' => 'welcome#all_messages', as: 'profile'
  resources :songs do
    collection { post :import }
  end
  resources :feedbacks, except: :show do
    put :publish, on: :member
  end
  get '/contacts' => 'messages#new', as: 'contacts'
  resources :messages, :disks, except: :show

  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"
  get "sign_up" => "users#new", as: "sign_up"
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'high_voltage/pages#show', id: 'main_page'
end
