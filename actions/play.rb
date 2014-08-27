require_relative 'action'
class Play < Action

  def initialize
    @name = "Play"
    @img ="play.png"
    @description ="Play this card"
    @priority =1
  end

  def actionnable?
    super && @owner.in_hand? &&
      ( $world.turn.phase.is_a?(Pre) ||
        $world.turn.phase.is_a?(Post) ||
        $world.turn.phase.is_a?(DiscardPhase)  ) && card.can_be_played? && card.owner.playing?
  end

  def execute!
    card.owner.play! card
  end


end
