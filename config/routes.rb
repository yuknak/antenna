Rails.application.routes.draw do
  root 'top#index'
  get '/about', to: 'about#index'
  namespace :admin do
    root 'top#index'
    resources :daily_out_counts
    resources :daily_in_counts
    resources :articles
    resources :sites
    resources :categories
    resources :article_out_counts
  end
  get '/:id', to: 'top#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
