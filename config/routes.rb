Antispam::Engine.routes.draw do
  resources :clears
  resources :blocks
  resources :challenges
  resources :signups
  root to: 'ips#index'
  get 'validate', to: 'validate#index'
end
