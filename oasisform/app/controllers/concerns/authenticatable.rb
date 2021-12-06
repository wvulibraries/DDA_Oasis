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

  # login methods
  def login
    if authenticated?
      redirect_to root_path, success: I18n.t('auth.success')
    else
      render(plain: 'Unauthorized!', status: :unauthorized)
    end
  end

  # logout
  def logout
    session.delete('cas')
    redirect_to root_path, success: I18n.t('auth.log_out')
  end
end