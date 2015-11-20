Rails.application.routes.draw do
  root "jobs#index"

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}
  resources :jobs
  resources :users, only: :show

  get '/:city_id', to: 'jobs#index'
  get '/users/edit/avatar', to: 'users#edit_avatar'
  patch '/users/:id', to: 'users#update_avatar'

  mount TaiwanCity::Engine => '/taiwan_city'
end
