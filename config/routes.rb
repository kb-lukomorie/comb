InsalesApp::Application.routes.draw do

  root to: 'pages#main'

  resources :profiles

  resource  :session do
    collection do
      get :autologin
    end
  end

  match '/install',     to: 'insales_app#install',   as: :install
  match '/uninstall',   to: 'insales_app#uninstall', as: :uninstall
  match '/login',       to: 'sessions#create',       as: :login
  match '/main',        to: 'pages#main',            as: :main
  match '/description', to: 'pages#description',     as: :description

  mount Resque::Server, at: '/resque'
end
