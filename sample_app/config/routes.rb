Rails.application.routes.draw do
  root 'static_pages#home'
  get 'users/new', as: 'signup'
  get '/help', to: 'static_pages#help', as: 'helf'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'  
end
