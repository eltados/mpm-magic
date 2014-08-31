class Play < Action

  def initialize
    @name = "Play"
    @img ="play.png"
    @description ="Play this card"
    @priority =1
  end

  def actionnable?
    super && card.in_hand? &&
      ( world.turn.phase.is_a?(Pre) ||
        world.turn.phase.is_a?(Post) ||
        world.turn.phase.is_a?(DiscardPhase)  ) && card.can_be_played? && card.owner.playing?
  end

  def execute!
    player.play! card
  end


end
