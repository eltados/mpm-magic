class ActionWithTarget <Action

  def initialize(owner=nil)
    super(owner)
  end

  def can_be_activated
    true
  end

  def can_target(target)
    target.is_a? Creature
  end

  def execute!
    player.target_action = TargetAction.new(card, self)
  end


  def execute_with_target!(target)
    world.log Log.new(description: "#{card.name} #{self.name.downcase}s #{target.name}" , card: card, target: target , action:self)
    card.flags[:target] = target
  end


end
