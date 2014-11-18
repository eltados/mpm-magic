require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class DrawTest < Minitest::Unit::TestCase
  def setup
    @p1 = Player.new
  end

  def test_draw_ability
    mob = Mob.new(@p1)
    assert_equal false,  mob.has_ability(Draw)
    assert_equal false,  mob.has_action(Draw)
    mob.add_abilities [Draw]
    # assert_equal true,  mob.has_ability(DrawAbility) TODO
    assert_equal true,  mob.has_action(Draw)
    action1  = mob.action(Draw)
    refute nil,action1
    action2  = mob.action(Draw)
    assert_equal action1, action2

  end

end
