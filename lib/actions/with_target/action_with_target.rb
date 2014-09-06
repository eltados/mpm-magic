class ActionWithTarget <Action

  def initialize(owner=nil)
    super(owner)
  end

  def can_be_activated
  end

  def can_target(target)
    target.is_a? Creature
  end

  def execute!
    player.target_action = TargetAction.new(card, self)
  end


end
