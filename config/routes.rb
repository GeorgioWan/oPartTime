Rails.application.routes.draw do

  root "jobs#index"

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}
  resources :jobs
  resources :users, only: :show

  get '/:city_id', to: 'jobs#index'
  get '/user/favorite', to: 'users#favorite'
  post '/user/favorite', to: 'favorite_jobs#add'

  mount TaiwanCity::Engine => '/taiwan_city'
end
