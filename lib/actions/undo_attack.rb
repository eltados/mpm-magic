class UndoAttack < Action

  def initialize(owner=nil)
    super(owner)
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
    super
    card.undo_attack!
  end

  def log
    "#{player.name} #{name.downcase}s of #{card.name}"
  end

end
