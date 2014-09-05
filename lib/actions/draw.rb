class DrawAction < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Draw"
    @img ="draw.png"
    @description ="{Tap} : Draw a card"
    @priority =2
  end

  def can_be_activated
    super && card.in_play? && (
      world.turn.phase.is_a?(Pre) ||
      world.turn.phase.is_a?(Combat) || world.turn.phase.is_a?(Post)
   )  &&  card.can_be_activated
  end

  def execute!
    super
    card.tap!
    player.draw!
  end


end
