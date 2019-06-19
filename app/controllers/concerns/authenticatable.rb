# app/controllers/concerns/authenticatable.rb 
module Authenticatable
  extend ActiveSupport::Concern

  # detrmine if the user can access the admin panel
  def access_permissions
    return true if authenticated?

    render(plain: 'Unauthorized!', status: :unauthorized)
  end

  # look to see if authenticated
  def authenticated?
    session['cas'] && session['cas']['user']
  end
end
