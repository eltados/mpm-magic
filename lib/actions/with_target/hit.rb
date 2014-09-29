class HitAction < ActionWithTarget

  def initialize(owner=nil)
    super(owner)
    @name = "Hit"
    @img ="hit.png"
    @description ="{Tap} : deal 1 damage to target creature"
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
    target.hit! 1
    player.target_action =nil
  end


end
