class UndoAttack < Action

  def initialize
    @name = "Undo Attack"
    @img ="undo.png"
    @description ="Remove this card from attack"
    @priority =1
  end

  def actionnable?
    super && card.in_play? && world.turn.phase.is_a?(Combat) && \
    card.flags[:attacking] == true &&\
    player.playing?
  end

  def execute!
    card.undo_attack!
  end

  def log
    "#{player.name} #{nadowncase}s of #{card.name}"
  end

end
