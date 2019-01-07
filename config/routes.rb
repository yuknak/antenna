Rails.application.routes.draw do
  namespace :admin do
    root 'top#index'
    resources :daily_out_counts
    resources :daily_in_counts
    resources :out_histories
    resources :in_histories
    resources :articles
    resources :sites
    resources :categories
    resources :article_out_counts
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
