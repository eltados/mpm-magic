require_relative 'action'
class UndoAttack < Action

  def initialize
    @name = "Undo Attack"
    @img ="undo.png"
    @description ="Remove this card from attack"
    @priority =1
  end

  def actionnable?
    super && @owner.in_play? && $world.turn.phase.is_a?(Combat) &&  @owner.flags[:attacking] == true && card.owner.playing?
  end

  def execute!
    card.undo_attack!
  end

end
