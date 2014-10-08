require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class MultiBlockTest < Minitest::Unit::TestCase
  def setup
    @p1 = Player.new
    @p1.name ="P1"
    @p2 = Player.new
    @p2.name ="P2"
    @world = World.new(@p1, @p2)

    @wolf = Wolf.new(@p1)
    @spider = Spider.new(@p1)
    @spider2 = Spider.new(@p1)
    @orgg_p1 = Orgg.new(@p1)
    @mob = Mob.new(@p1)
    @orgg = Orgg.new(@p2)
    @p1.permanents << @wolf
    @p1.permanents << @spider
    @p1.permanents << @spider2
    @p1.permanents << @orgg_p1
    @p1.permanents << @mob

    @p2.permanents << @orgg

    @world.turn.phase = ResolveCombat
    @world.playing_player = @p2

    @phase  = @world.turn.phase
  end

  def test_multi_block
    # skip
    @orgg.flags[:attacking] =true
    @orgg.flags[:blocked] =true

    @spider.flags[:blocking] = true
    @spider.flags[:blocked_creature] = @orgg

    @spider2.flags[:blocking] = true
    @spider2.flags[:blocked_creature] = @orgg

    @wolf.flags[:blocking] = true
    @wolf.flags[:blocked_creature] = @orgg

    @phase.execute

    assert_equal true, @orgg.dead? ,  "the orgg should be dead"
    assert_equal true, @spider2.dead? || @spider.dead? ,  "one of the spider should be dead"
    assert_equal false, @spider2.dead? && @spider.dead? ,  "only one of the spider should be dead"
    assert_equal true, @wolf.dead?, "the wolf should dead"
  end

  def test_multi_with_mob
    @orgg.flags[:attacking] =true
    @orgg.flags[:blocked] =true

    @mob.flags[:blocking] = true
    @mob.flags[:blocked_creature] = @orgg

    @orgg_p1.flags[:blocking] = true
    @orgg_p1.flags[:blocked_creature] = @orgg
    @orgg_p1.dmg = -1
    @orgg_p1.attack_bonus = -3

    @mob.dmg = -6


    @phase.execute


    assert_equal 2, @orgg.health
    assert_equal 1, @orgg_p1.health
    assert_equal 7, @mob.health
  end


end
