class SacrificeHitAction < ActionWithTarget

  def initialize(owner=nil)
    super(owner)
    @name = "Explode"
    @img ="hit.png"
    @description ="{Sacrifice} : deal 4 dommage to target creature"
    @priority =2
  end

  def can_be_activated
    card.in_play?
  end


  def can_target(target)
      target.is_a?(Creature) && target.in_play?
  end

  def execute_with_target!(target)
    super(target)
    card.sacrify!
    target.hit! 4
    player.target_action =nil
  end


end
