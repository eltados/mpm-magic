require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class TestPlayer < Minitest::Test
  def setup
    @p = Player.new
  end

  def test_name
    assert_equal "Player", @p.name
  end

  def test_name
    assert_equal "Player", @p.name
  end



  # def test_name
  #   assert_equal "Player1", @p.name
  # end
  #
  # def test_that_it_will_not_blend
  #   refute_match /^no/i, @meme.will_it_blend?
  # end
  #
  # def test_that_will_be_skipped
  #   skip "test this later"
  # end
end
