Rails.application.routes.draw do
  resources :microposts
  resources :users
  root 'users#index'
  
  # other routing options
  #root 'users#new'
  #root 'users#show', :defaults => { :id => 1}
end
