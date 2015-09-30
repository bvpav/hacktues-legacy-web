Rails.application.routes.draw do
  root                'static_pages#home'
  get 'help'       => 'static_pages#help'
  get 'about'      => 'static_pages#about'
  get 'team'       => 'static_pages#team'

  # close sign-ups
  # get 'signup'     => 'users#new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  post 'login/remote' => 'sessions#create_remote'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  get 'users/:id/check' => 'users#check'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :teams
  patch 'team.:id' => 'teams#update'
  resources :pages,               only: [:new, :create, :edit, :update,
                                         :destroy]
  resources :articles

  get 'teams/:id/leave'  => 'teams#leave'

  get 'invites/send'    => 'teams#send_invite'
  get 'invites/cancel'  => 'teams#cancel_invite'
  get 'invites/accept'  => 'teams#accept_invite'
  get 'invites/decline' => 'teams#decline_invite'

  get '/:id' => 'pages#show'
end
