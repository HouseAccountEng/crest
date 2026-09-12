require 'test_helper'

class Crest::PhotoTest < ActiveSupport::TestCase
  test 'a photo is typed by its own first bytes rather than by what it was called' do
    assert_includes Crest::Photo.new("\x89PNG cube").property, 'TYPE=PNG:'
    assert_includes Crest::Photo.new("\xFF\xD8\xFF cube").property, 'TYPE=JPEG:'
  end

  test 'a photo read from a path holds what that file holds' do
    path = Rails.root.join 'public/cube.jpg'

    assert_equal Crest::Photo.new(path.binread).property, Crest::Photo.new(path).property
  end

  test 'a photo in a format no phone reads is left out, and said so once' do
    photo = nil
    _, warning = capture_io { photo = Crest::Photo.new 'GIF89a cube' }

    assert_equal "#{Crest::Photo::UNREADABLE}\n", warning
    assert_nil photo.property
  end
end
