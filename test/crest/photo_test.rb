require 'test_helper'

class Crest::PhotoTest < ActiveSupport::TestCase
  test 'a photo is typed by its own first bytes rather than by what it was called' do
    assert_includes Crest::Photo.of("\x89PNG cube").to_s, 'TYPE=PNG:'
    assert_includes Crest::Photo.of("\xFF\xD8\xFF cube").to_s, 'TYPE=JPEG:'
  end

  test 'a photo read from a path holds what that file holds' do
    read = Crest::Photo.of Rails.root.join('public/cube.jpg')

    assert_equal Crest::Photo.of(Rails.root.join('public/cube.jpg').binread).to_s, read.to_s
  end

  test 'a photo in a format no phone reads is refused' do
    error = assert_raises(Crest::Error) { Crest::Photo.of('GIF89a cube').to_s }

    assert_equal 'a photo has to be a PNG or a JPEG', error.message
  end
end
