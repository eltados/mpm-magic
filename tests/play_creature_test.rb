require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class PlayCreatureTest < Minitest::Unit::TestCase
  def setup
    @p1 = Player.new
    @p2 = Player.new
    @world = World.new(@p1, @p2)

    @mob = Mob.new(@p1)
    @p1.hand << @mob
    @p1.mana_pool.mana = 100
    @world.turn.phase = Pre
    @play = @mob.action(Play)
  end

  def test_not_enought_mana
    @p1.mana_pool.mana = 0
    assert_equal  false , @play.can_be_activated
  end


  def test_not_in_hand
    @p1.hand = []
    assert_equal  false , @play.can_be_activated
  end

  def test_wrong_phase
    @world.turn.phase = Combat
    assert_equal  false , @play.can_be_activated
  end

  def test_player_not_playing
    @world.switch_playing_player!
    assert_equal  false , @play.can_be_activated
  end

  def test_can_play
    assert_equal  true , @mob.can_be_played
    assert_equal  true , @play.can_be_activated
  end

end
