Rails.application.routes.draw do
  root to: 'form#index'
  post '/' => 'form#submit', as: :form_submit
  get '/success', to: 'form#success', as: :form_success
end
