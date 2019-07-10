Rails.application.routes.draw do
  root to: 'form#create'

  match "/create" => "form#create", via: [:get, :post]

  post '/submit', 
      to: 'form#submit',
      as: :form_submit

  get '/success', 
      to: 'form#success',
      as: :form_success

  # auth
  get '/login',
      to: 'application#login',
      as: 'login'

  get '/logout',
      to: 'application#logout',
      as: 'logout'
end
