class TransformAction < ActionWithTarget

  def initialize(owner=nil)
    super(owner)
    @name = "Transform"
    @img ="transform.png"
    @description ="{Tap} : attack of target creature is multipled by 2"
    @priority =2
  end

  def can_be_activated
    super && card.in_play? && card.can_be_activated
  end


  def can_target(target)
      target.is_a?(Creature) && target.in_play?
  end

  def execute_with_target!(target)
    card.tap!
    target.attack_bonus += target.attack
    player.target_action =nil
  end


end
