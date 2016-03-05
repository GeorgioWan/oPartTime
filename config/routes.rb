Rails.application.routes.draw do

  root "oparttime#index"
  
  concern :paginatable_index do
    get '(page/:page)', action: :index, on: :collection
  end
  concern :paginatable_show do
    get '(page/:page)', action: :show, on: :collection
  end

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}
  resources :jobs, concerns: :paginatable_index
  resources :users, only: :show, concerns: :paginatable_show
  resource :favorite_job, only: [:index, :create, :destroy], path: 'user/favorite', as: 'user_favorite', concerns: :paginatable_show

  scope controller: :oparttime do
    get '/about'   => :about
    get '/privacy' => :privacy
    get '/policy'  => :policy
  end
  
  scope controller: :admin do
    get  '/admin/accepted'  => :accepted
    post '/admin/accepted'  => :update
  end

  mount TaiwanCity::Engine => '/taiwan_city'
end
