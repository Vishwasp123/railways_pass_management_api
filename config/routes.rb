Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post 'auth_login', to: 'auth#login'
  post 'signup', to: "users#create"
  get 'show', to: "users#show"
  delete 'auth_logout', to: 'auth#logout'
  resources :passes
  resources :pages


  post 'payment_create', to: 'passes#payment_create'
  post 'stripe_token', to: 'passes#stripe_token'
  post 'stripe_customer', to: 'passes#stripe_customer'

  #pass_controller abouts_us routes
  post'about_us_create', to: 'pages#create_about_us'
  put 'update_about_us/:id', to: 'pages#update_about_us'

  #pass_controller contact_us routes
  post 'create_contact_us', to: 'pages#create_contact_us'
  put 'update_contact_us/:id', to: 'pages#update_contact_us'

  #enquiry_cotroller 
  resources :enquiry

  #report
  get 'pass_report', to: 'reports#report'


  #Stripe routes
    # resources :payments
end
