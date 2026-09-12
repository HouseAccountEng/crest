require_relative 'boot'

require 'rails'
require 'action_controller/railtie'

Bundler.require(*Rails.groups)

# Stands in for an app that hands out a card: one route, one initializer, and nothing else.
module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    config.eager_load = false
    config.time_zone = 'Eastern Time (US & Canada)'
    config.secret_key_base = 'dummy-secret-key-base'
  end
end
