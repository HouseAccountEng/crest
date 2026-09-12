require 'crest/error'

module Crest
  # Every fact about the app a card is handed out by, so none of the gem's own classes names one.
  # A host states each as a value or as something callable, and a callable is asked every time a
  # card is drawn: an app reading its number out of the environment differs between production and
  # staging, and one read at boot would be wrong in one of them until a restart.
  class Config
    # What a host states, each resolved when a card is drawn rather than when this is written.
    attr_writer :name, :phone, :url, :email, :org, :photo

    # @return [String] name the card is saved under, which the gem cannot invent.
    def name = resolve(@name) || missing('name')

    # @return [String] number a text of ours arrives from, which the gem cannot invent.
    def phone = resolve(@phone) || missing('phone')

    # @return [String] address of the site behind the name, left out of the card where unset.
    def url = resolve @url

    # @return [String] address somebody may write back to, left out of the card where unset.
    def email = resolve @email

    # @return [String] organization the name stands for, left out of the card where unset.
    def org = resolve @org

    # @return [String, Pathname] picture the card carries, left out of the card where unset.
    def photo = resolve @photo

  private

    def resolve(setting) = setting.respond_to?(:call) ? setting.call : setting

    def missing(setting) = raise(Error, "Crest.config.#{setting} has to be set")
  end
end
