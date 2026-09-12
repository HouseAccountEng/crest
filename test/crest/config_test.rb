require 'test_helper'

class Crest::ConfigTest < ActiveSupport::TestCase
  test 'a setting stated as a callable is asked again every time it is read' do
    numbers = [ '+18005550100', '+18005550111' ].each
    config = Crest::Config.new
    config.phone = -> { numbers.next }

    assert_equal '+18005550100', config.phone
    assert_equal '+18005550111', config.phone
  end

  test 'the two facts the gem cannot invent are refused rather than left blank' do
    config = Crest::Config.new

    assert_equal 'Crest.config.name has to be set',
                 assert_raises(Crest::Error) { config.name }.message
    assert_equal 'Crest.config.phone has to be set',
                 assert_raises(Crest::Error) { config.phone }.message
  end
end
