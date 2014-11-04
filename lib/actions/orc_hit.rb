class OrcHit < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Hit"
    @img ="hit.png"
    @description ="{Tap} : deals 2 damage to target creature and 3 damage to you."
    @priority =2
  end

  def required_targets
    1
  end

  def can_be_activated
    super && card.in_play?  && card.can_be_activated
  end


  def can_target(target)
     target.is_a?(Creature) && target.in_play?
  end

  def pay!
    card.tap!
  end

  def execute!
    super
    target.hit! 2
    player.hits_player!(3, card)
  end


end
