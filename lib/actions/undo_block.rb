class UndoBlock < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Undo Bock"
    @img ="undo.png"
    @description ="Remove this card from blocking"
    @priority =1
  end

  def actionnable?
    super && card.in_play? && world.turn.phase.is_a?(BlockPhase) && \
    card.flags[:blocking] == true &&\
    player.active?
  end

  def execute!
    card.undo_block!
  end

  def log
    "#{player.name} #{name.downcase}s of #{card.name}"
  end

end
