module Crest
  # Hands out the contact card. It descends from ActionController::Base rather than from the
  # host's ApplicationController on purpose: the card is public by definition, and an inherited
  # `before_action :authenticate` would refuse the one request this exists to answer.
  class CardsController < ActionController::Base
    # What a phone has to be told the body is before it offers to save it.
    TYPE = 'text/vcard; charset=utf-8'

    # Answers the card, named after the path it was drawn at and cached until the card changes.
    # @return [void]
    def show
      card = Crest.card.to_s

      if stale?(etag: card, public: true)
        send_data card, type: TYPE, disposition: 'inline', filename: File.basename(request.path)
      end
    end
  end
end
