require_relative 'ability'
class Heal < Ability

  def initialize
    @name = "Heal"
    @img ="heal.png"
    @description ="Tap : Gain 1 PV"
  end

  def activable?
    super && @owner.tapped? == false
  end

  def activate!
    super
    @owner.owner.health += 1
  end

  def passive?
    false
  end


end
