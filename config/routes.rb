Rails.application.routes.draw do
  root to: 'item_request#new'

  match '/new', 
        to: 'item_request#new', via: [:get, :post],
        as: :item_request_new

  post '/submit',
       to: 'item_request#submit',
       as: :item_request_submit

  get '/submit',
      to: 'item_request#new'

  get '/success', 
      to: 'item_request#success',
      as: :item_request_success

  # auth
  get '/login',
      to: 'application#login',
      as: 'login'

  get '/logout',
      to: 'application#logout',
      as: 'logout'
end
