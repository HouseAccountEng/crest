require 'test_helper'

class Crest::FoldingTest < ActiveSupport::TestCase
  setup do
    @card = Crest::Card.new name: 'HouseAccount', phone: '+18005550100',
                            photo: Rails.root.join('public/cube.png')
  end

  test 'no line of a card runs past what the format allows' do
    @card.to_s.split("\r\n").each { |line| assert_operator line.length, :<=, 74 }
  end

  test 'a photo too long for one line continues on the next, under a single space' do
    continued = @card.to_s.split("\r\n").drop_while { |line| !line.start_with? 'PHOTO' }

    assert_operator continued.length, :>, 2
    assert continued[1].start_with?(' '), 'a continuation line begins with a space'
    assert_equal 'END:VCARD', continued.last
  end
end
