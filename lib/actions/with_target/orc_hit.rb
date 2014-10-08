class OrcHitAction < ActionWithTarget

  def initialize(owner=nil)
    super(owner)
    @name = "Hit"
    @img ="hit.png"
    @description ="{Tap} : deals 2 damage to target creature and 3 damage to you."
    @priority =2
  end

  def can_be_activated
    card.in_play? && card.can_be_activated
  end


  def can_target(target)
      target.is_a?(Creature) && target.in_play?
  end

  def execute_with_target!(target)
    super(target)
    card.tap!
    target.hit! 2
    player.hits_player!(3, card)
    player.target_action =nil
  end


end
