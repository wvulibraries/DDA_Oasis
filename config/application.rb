require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oasisform
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Time Zone
    config.time_zone = 'Eastern Time (US & Canada)'

    # CAS
    config.rack_cas.server_url = 'https://ssodev.wvu.edu/cas/' unless Rails.env.production?
    config.rack_cas.server_url = 'https://sso.wvu.edu/cas/' if Rails.env.production?

    # force ssl
    # config.force_ssl = true if Rails.env.production?

    # session store
    config.session_store :cookie_store, expire_after: nil, secure: true if Rails.env.production?
    config.session_store :cookie_store, key: 'cas', expire_after: 12.hours, secure: true if Rails.env.production?


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
