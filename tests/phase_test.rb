require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class PhaseTest < Minitest::Test
  def setup
    @p1 = Player.new
    @p2 = Player.new
    @world = World.new(@p1, @p2)
    
  end

  def test_phase
    assert_equal  Draw , @world.turn.phase.class
    @world.turn.phase= Unkeep
    assert_equal  Unkeep , @world.turn.phase.class

  end

end
