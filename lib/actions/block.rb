class Block < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Block"
    @img ="block.png"
    @description ="Block"
    @priority = 1
  end



  def can_be_activated
    card.in_play? \
    && player.active? \
    && player.opponent.creatures.select { |c| c.flags[:attacking] }.size > 0 \
    && card.can_block_any(player.opponent.creatures.select { |c| c.flags[:attacking] })
  end

  def can_target(target)
    target.flags[:attacking] && card.can_block_creature(target)
  end

  def pay!
    card.block! target
  end

  def required_targets
    1
  end

  def react_time
    0
  end


  def execute!
    super
  end

end
