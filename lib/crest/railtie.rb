require 'crest/routes'

module Crest
  # Teaches a host's routes file the `crest` method, and loads the controller that answers it.
  class Railtie < ::Rails::Railtie
    initializer 'crest.routes' do |app|
      ActionDispatch::Routing::Mapper.include Crest::Routes

      # Loaded once the routes are drawn, so the controller inherits the host's own URL helpers
      # the way a controller the host wrote does.
      app.config.to_prepare { require 'crest/cards_controller' }
    end
  end
end
