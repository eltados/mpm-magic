class PlayWithTarget < ActionWithTarget

  def initialize(owner=nil)
    super(owner)
    @name = "Play"
    @img ="play.png"
    @description = owner.name
    @priority =1
  end

  def can_be_activated
    card.in_hand? && card.can_be_played
  end


  def can_target(target)
      card.can_target(target)
  end

  def execute_with_target!(target)
    super(target)
    player.play_with_target!(card, target)
    player.target_action =nil
  end
end
