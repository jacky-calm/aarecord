Aarecord::Application.routes.draw do
  resources :bills do
    post 'pay', :on => :member
  end


  resources :accounts


  authenticated :user do
    root :to => 'accounts#index'
  end
  root :to => "accounts#index"
  devise_for :users
  resources :users
end
