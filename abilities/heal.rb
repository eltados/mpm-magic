require_relative 'ability'
require_relative '../actions/heal'
class HealAbility < Ability

  def initialize
    @name = "Heal"
    @img ="heal.png"
    @description ="Tap : Gain 1 PV"
  end

  def play!
    card.add_action Heal.new
  end


end
