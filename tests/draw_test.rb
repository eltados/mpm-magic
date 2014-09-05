require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class DrawAbilityTest < Minitest::Test
  def setup
    @p1 = Player.new
  end

  def test_draw_ability
    mob = Mob.new(@p1)
    assert_equal false,  mob.has_ability(DrawAbility)
    assert_equal false,  mob.has_action(DrawAction)
    mob.add_abilities [DrawAbility]
    assert_equal true,  mob.has_ability(DrawAbility)
    assert_equal true,  mob.has_action(DrawAction)
    action1  = mob.action(DrawAction)
    refute nil,action1
    action2  = mob.action(DrawAction)
    assert_equal action1, action2

  end

end
