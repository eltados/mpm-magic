class Hit < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Hit"
    @img ="hit.png"
    @description ="{Tap} : deal 1 damage to target creature"
    @priority =2
  end


  def can_be_activated
    super && card.can_be_activated
  end

  def can_target(target)
      target.is_a?(Creature) && target.in_play?
  end

  def pay!
    card.tap!
  end

  def required_targets
    1
  end

  def execute!
    super
    target.hit! 1
  end

end
