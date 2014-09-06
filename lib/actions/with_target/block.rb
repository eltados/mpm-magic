class Block < ActionWithTarget

  def initialize(owner=nil)
    super(owner)
    @name = "Block"
    @img ="http://icons.iconarchive.com/icons/rafiqul-hassan/blogger/24/Shield-icon.png"
    @description ="Block"
    @priority = 1
  end

  def can_be_activated
    card.in_play? \
    && !player.playing? \
    && phase.is_a?(BlockPhase) \
    && player.opponent.creatures.select { |c| c.flags[:attacking] }.size > 0 \
    && card.can_block_any(player.opponent.creatures.select { |c| c.flags[:attacking] })
  end

  def can_target(target)
    target.flags[:attacking] && card.can_block_creature(target) && ! target.flags[:blocked]
  end

  def execute_with_target!(target)
    world.logs << "#{player.name} blocks #{target.name} with #{card.name}"
    card.block! target
  end

  def log
    "#{player.name} blocks with #{card.name}"
  end

end
