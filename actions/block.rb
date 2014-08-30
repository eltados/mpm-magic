require_relative 'action'
require_relative '../target_action'
class Block < Action

  def initialize
    @name = "Block"
    @img ="http://icons.iconarchive.com/icons/rafiqul-hassan/blogger/24/Shield-icon.png"
    @description ="Block"
    @priority = 1
  end

  def actionnable?
    super \
    && !card.owner.playing? \
    && card.in_play? \
    && $world.turn.phase.is_a?(BlockPhase) \
    && !card.tapped? \
    && !card.flags[:blocking] \
    && card.owner.opponent.creatures.select { |c| c.flags[:attacking] }.size > 0
  end

  def execute!
    a = TargetAction.new(card, self)
    $world.target_action =a
  end

  def can_target?(target)
    target.flags[:attacking] && \
    ( ! target.has_ability?(Flying) || ( target.has_ability?(Flying) && card.has_ability?(Flying)) )
  end



  def execute_with_target!(target)
    puts target.name
    card.block! target
    $world.target_action =nil
  end

  def log
    "#{card.owner.name} #{name.downcase}s with #{card.name}"
  end

end
