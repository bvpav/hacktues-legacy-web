Rails.application.routes.draw do
  root                'static_pages#home'
  get 'help'       => 'static_pages#help'
  get 'about'      => 'static_pages#about'
  get 'team'       => 'static_pages#team'
  get 'signup'     => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :teams               #only: [:index, :show]
  resources :pages,               only: [:new, :create, :edit, :update,
                                         :destroy]
  get '/:id'       => 'pages#show'
end
