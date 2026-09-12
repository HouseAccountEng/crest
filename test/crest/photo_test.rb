require 'test_helper'

class Crest::PhotoTest < ActiveSupport::TestCase
  test 'a photo is typed by its own first bytes rather than by what it was called' do
    assert_includes Crest::Photo.of("\x89PNG cube").property, 'TYPE=PNG:'
    assert_includes Crest::Photo.of("\xFF\xD8\xFF cube").property, 'TYPE=JPEG:'
  end

  test 'a photo read from a path holds what that file holds' do
    read = Crest::Photo.of Rails.root.join('public/cube.jpg')

    assert_equal Crest::Photo.of(Rails.root.join('public/cube.jpg').binread).property, read.property
  end

  test 'a photo in a format no phone reads is left out, and said so once' do
    photo = nil
    _, warning = capture_io { photo = Crest::Photo.of 'GIF89a cube' }

    assert_equal "#{Crest::Photo::UNREADABLE}\n", warning
    assert_nil photo.property
  end
end
