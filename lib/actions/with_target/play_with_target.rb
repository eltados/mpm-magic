class PlayWithTarget < ActionWithTarget

  def initialize(owner=nil)
    super(owner)
    @name = "Play"
    @img ="nightmare.png"
    @description ="Play this card"
    @priority =1
  end

  def can_be_activated
    card.in_hand? && card.can_be_played
  end


  def can_target(target)
      target.is_a?(Creature) && target.in_play? && !target.tapped?
  end

  def execute_with_target!(target)
    super(target)
    player.play_with_target!(card, target)
    player.target_action =nil
  end
end
