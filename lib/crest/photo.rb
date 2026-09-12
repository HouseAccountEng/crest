module Crest
  # The picture a card carries: bytes as they were handed over, or the file a path names.
  class Photo
    # The first bytes of each image format a phone will read a saved card's picture from.
    SIGNATURES = { 'PNG' => "\x89PNG".b, 'JPEG' => "\xFF\xD8\xFF".b }

    # What a host hears, once, about a picture no phone would draw.
    UNREADABLE = 'crest: the photo is neither a PNG nor a JPEG, so the card goes out without it'

    # The picture a path or a string of bytes stands for, read from disk only the first time,
    # so a card handed out a thousand times costs one read and one encoding.
    # @return [Crest::Photo] picture that file holds, or those bytes are.
    def self.of(photo)
      @read ||= {}
      @read[photo] ||= new photo
    end

    # @param photo [String, Pathname] image bytes, or the file to read them from.
    def initialize(photo)
      @bytes = photo.respond_to?(:binread) ? photo.binread : photo
      @type = SIGNATURES.find { |_, signature| @bytes.b.start_with? signature }&.first
      warn UNREADABLE unless @type
    end

    # @return [String] PHOTO property, or nothing where the bytes are in no format a phone reads.
    def property
      @property ||= "PHOTO;ENCODING=b;TYPE=#{@type}:#{[@bytes].pack 'm0'}" if @type
    end
  end
end
