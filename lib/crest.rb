require 'crest/error'
require 'crest/version'
require 'crest/config'
require 'crest/card'

# Rails-only from here: the builder above is plain Ruby, and a script may load it on its own.
require 'crest/railtie' if defined?(Rails)

# A contact card an app hands out, so a text from an unknown number arrives under a name.
module Crest
  # @return [Crest::Config] everything a card has to be told about the app around it.
  def self.config = @config ||= Config.new

  # Yields the configuration, so a host states its own facts in one initializer.
  # @return [void]
  def self.configure = yield config

  # Built afresh for every request, since a setting stated as a callable is asked each time.
  # @return [Crest::Card] card this app is saved under.
  def self.card
    Card.new name: config.name, phone: config.phone, url: config.url, email: config.email,
             org: config.org, photo: config.photo
  end
end
