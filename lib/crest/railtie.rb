require 'crest/routes'

module Crest
  # Left to Ruby to load when a request first names it. Requiring it at boot would load
  # ActionController::Base before the host had finished initializing, which costs boot time and
  # which Rails reports as a prematurely executed load hook.
  autoload :CardsController, 'crest/cards_controller'

  # Teaches a host's routes file the `crest` method.
  class Railtie < ::Rails::Railtie
    initializer 'crest.routes' do
      ActionDispatch::Routing::Mapper.include Crest::Routes
    end
  end
end
