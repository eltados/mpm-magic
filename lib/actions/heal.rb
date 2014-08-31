class Heal < Action

  def initialize
    @name = "Heal"
    @img ="heal.png"
    @description ="Tap : Gain 1 PV"
    @priority =2
  end

  def actionnable?
    super && card.in_play? && (
      $world.turn.phase.is_a?(Pre) ||
      $world.turn.phase.is_a?(Combat) || $world.turn.phase.is_a?(Post)
   )  &&  @owner.activable?
  end

  def execute!
    card.tap!
    card.owner.health += 1
  end


end
