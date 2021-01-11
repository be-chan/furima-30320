Rails.application.routes.draw do
  devise_for :users
  root to:'items#index'
  resources :items do
    resources :purchase_recodes, only:[:index, :new, :create]
  end
  resources :users, only:[:new, :create]
  resources :addresses, only:[:index, :new, :create]
end
