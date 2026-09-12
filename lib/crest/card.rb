require 'crest/photo'

module Crest
  # An organization's contact card, written as the vCard 3.0 a phone offers to save.
  class Card
    # What a line may hold before a vCard folds it, less the space that continues it.
    FOLD = 74

    # @param name [String] organization the card is saved under.
    # @param phone [String] number in the form a phone should dial it.
    # @param url [String] address of the site behind the name.
    # @param email [String] address somebody may write back to.
    # @param org [String] organization the name stands for.
    # @param photo [String, Pathname] image bytes, or the file to read them from.
    def initialize(name:, phone:, url: nil, email: nil, org: nil, photo: nil)
      @name = name
      @phone = phone
      @url = url
      @email = email
      @org = org
      @photo = photo
    end

    # @return [String] card itself, CRLF-delimited and folded, as the format asks.
    def to_s = lines.flat_map { |line| fold line }.join("\r\n") << "\r\n"

  private

    def lines
      [
        'BEGIN:VCARD', 'VERSION:3.0',
        "N:;#{@name};;;", "FN:#{@name}",
        ("ORG:#{@org}" if @org),
        "TEL;TYPE=CELL:#{@phone}",
        ("URL:#{@url}" if @url),
        ("EMAIL;TYPE=INTERNET:#{@email}" if @email),
        (Photo.of(@photo).to_s if @photo),
        'END:VCARD',
      ].compact
    end

    def fold(line)
      return [line] if line.length <= FOLD

      # A long line continues on the next one, which a single space marks as the same line.
      [line[0, FOLD], *line[FOLD..].scan(/.{1,#{FOLD - 1}}/).map { |part| " #{part}" }]
    end
  end
end
