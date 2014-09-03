class Block < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Block"
    @img ="http://icons.iconarchive.com/icons/rafiqul-hassan/blogger/24/Shield-icon.png"
    @description ="Block"
    @priority = 1
  end

  def can_be_activated
    super \
    && !player.playing? \
    && card.in_play? \
    && world.turn.phase.is_a?(BlockPhase) \
    && player.opponent.creatures.select { |c| c.flags[:attacking] }.size > 0 \
    && card.can_block_any(player.opponent.creatures.select { |c| c.flags[:attacking] })
  end

  def execute!
    super
    a = TargetAction.new(card, self)
    world.target_action =a
  end

  def can_target?(target)
    target.flags[:attacking] && card.can_block_creature(target)
  end



  def execute_with_target!(target)
    world.logs << "#{player.name} blocks #{target.name} with #{card.name}"
    card.block! target
    world.target_action =nil
  end

  def log
    "#{player.name} blocks with #{card.name}"
  end

end
