module Crest
  # Extends the config/routes.rb DSL, so `crest` draws a contact card wherever a host puts it.
  module Routes
    # Draws a GET at the path the host names, answered by the card the initializer describes.
    # The host names it because the filename is the app's own name, and the helper is named after
    # the file -- `crest 'houseaccount.vcf'` gives `houseaccount_vcf_path`. A route rather than an
    # engine to mount, so the line may sit inside a `scope` or a `constraints` the host wrote.
    # @param path [String] name the card is downloaded under, `.vcf` and all.
    # @return [void]
    def crest(path)
      get path, to: 'crest/cards#show', as: path.parameterize(separator: '_')
    end
  end
end
