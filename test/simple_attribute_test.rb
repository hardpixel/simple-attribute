require 'test_helper'

class SimpleAttributeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SimpleAttribute::VERSION
  end
end
