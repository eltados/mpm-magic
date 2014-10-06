require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class CreatureActionsTest < Minitest::Unit::TestCase
  def setup
    @p1 = Player.new
    @p2 = Player.new
    @world = World.new(@p1, @p2)

    @mob = Mob.new(@p1)
    @p1.permanents << @mob
    @p1.permanents << ConcordantCrossroads.new(@p1)
    @p1.mana_pool.mana = 100
    @world.turn.phase = Combat
  end



end
