require 'test_helper'

class Crest::CardTest < ActiveSupport::TestCase
  test 'a card names only what it was given' do
    card = Crest::Card.new name: 'HouseAccount', phone: '+18005550100'

    assert_equal [ 'BEGIN:VCARD', 'VERSION:3.0', 'N:;HouseAccount;;;', 'FN:HouseAccount',
                   'TEL;TYPE=CELL:+18005550100', 'END:VCARD', '', ], card.to_s.split("\r\n", -1)
  end

  test 'a card carries every field it was given' do
    card = Crest::Card.new name: 'HouseAccount', phone: '+18005550100', org: 'HouseAccount Inc',
                           url: 'https://houseaccount.com/', email: 'hello@houseaccount.com',
                           photo: "\x89PNG cube"

    assert_includes card.to_s, "\r\nORG:HouseAccount Inc\r\n"
    assert_includes card.to_s, "\r\nURL:https://houseaccount.com/\r\n"
    assert_includes card.to_s, "\r\nEMAIL;TYPE=INTERNET:hello@houseaccount.com\r\n"
    assert_includes card.to_s, "\r\nPHOTO;ENCODING=b;TYPE=PNG:"
  end
end
