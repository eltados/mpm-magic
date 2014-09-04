require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class SummoningSickNessTest < Minitest::Test
  def setup
    @p1 = Player.new
  end

  def test_creature_is_affected_by_summoning_sickness
    dragon = Dragon.new(@p1)
    assert_equal false,  dragon.has_ability(Haste)
    assert_equal false,  dragon.has_ability(SummoningSickness)
    assert_equal false,  dragon.can_attack

    dragon.stub :pay_cost!, (true) do
      dragon.play!
    end

    assert_equal true,  dragon.has_ability(SummoningSickness)
    assert_equal false,  dragon.can_attack
  end

  def test_creature_with_haste_is_not_affected_by_summoning_sickness
    gob = Gob.new @p1
    assert_equal true,  gob.has_ability(Haste)
    assert_equal false, gob.has_ability(SummoningSickness)
    assert_equal true, gob.can_attack

    gob.stub :pay_cost!, (true) do
      gob.play!
    end

    assert_equal false,  gob.has_ability(SummoningSickness)
    assert_equal true,  gob.can_attack
  end

end
