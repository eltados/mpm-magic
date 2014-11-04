class SacrificeHit < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Explode"
    @img ="explose.png"
    @description ="{Sacrifice} : deal 4 damage to target creature"
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
    card.sacrify!
  end

  def execute!
    target.hit! 4
  end

end
