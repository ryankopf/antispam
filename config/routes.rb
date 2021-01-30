Antispam::Engine.routes.draw do
  resources :challenges
  root to: 'ips#index'
  get 'validate', to: 'validate#index'
end
