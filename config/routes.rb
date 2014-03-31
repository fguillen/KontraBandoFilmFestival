KontraBandoFilmFestival::Application.routes.draw do
  root :to => "front/pages#show", :id => "coming_soon"

  namespace :front do
    resources :pages, :only => [:show]
    resources :short_film_users, :only => [:index, :show]
  end

  namespace :short_film do
    get "login", :to => "short_film_user_sessions#new", :as => :login
    get "logout", :to => "short_film_user_sessions#destroy", :as => :logout
    get "forgot_password", :to => "short_film_user_sessions#forgot_password", :as => :forgot_password
    post "forgot_password", :to => "short_film_user_sessions#forgot_password_send_email", :as => :forgot_password_send_email
    get "reset_password/:reset_password_code", :to => "short_film_users#reset_password", :as => :reset_password
    put "reset_password/:reset_password_code", :to => "short_film_users#reset_password_submit", :as => :reset_password_submit

    resources :short_film_user_sessions, :only => [:new, :create, :destroy]
    resources :short_film_users, :only => [:show, :new, :create, :edit, :update]
    resources :online_purchases, :only => [:create] do
      get :confirm, :on => :member
      get :cancel, :on => :member
    end
  end

  namespace :admin do
    root :to => "short_film_users#index"

    get "login", :to => "admin_user_sessions#new", :as => :login
    get "logout", :to => "admin_user_sessions#destroy", :as => :logout
    get "forgot_password", :to => "admin_user_sessions#forgot_password", :as => :forgot_password
    post "forgot_password", :to => "admin_user_sessions#forgot_password_send_email", :as => :forgot_password_send_email
    get "reset_password/:reset_password_code", :to => "admin_users#reset_password", :as => :reset_password
    put "reset_password/:reset_password_code", :to => "admin_users#reset_password_submit", :as => :reset_password_submit
    resources :admin_user_sessions, :only => [:new, :create, :destroy]

    resources :log_book_events, :only => [:index]
    resources :admin_users

    resources :online_purchases, :only => [:index, :show] do
      get :log_book_events, :on => :member
    end

    resources :short_film_users do
      get :log_book_events, :on => :member
    end
  end
end
