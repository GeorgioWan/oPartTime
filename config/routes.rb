Rails.application.routes.draw do

  root "jobs#index"

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}
  resources :jobs
  resources :users, only: :show
  resource :favorite_job, only: [:show, :create, :destroy], path: 'user/favorite', as: 'user_favorite'


  get '/:city_id', to: 'jobs#index'

  mount TaiwanCity::Engine => '/taiwan_city'
end
