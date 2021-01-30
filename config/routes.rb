Antispam::Engine.routes.draw do
  resources :clears
  resources :blocks
  resources :challenges
  root to: 'ips#index'
  get 'validate', to: 'validate#index'
end
