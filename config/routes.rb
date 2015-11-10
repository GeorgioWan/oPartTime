Rails.application.routes.draw do
  root "jobs#index"

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}
  resources :jobs

end
