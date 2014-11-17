class BoostAttackingOrBlockCreature < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Boost attacking"
    @img ="boost.png"
    @description ="{Tap}: Target attacking or blocking creature gets +1/+1 until end of turn."
    @priority =2
  end


  def can_be_activated
    super && card.can_be_activated && world.creatures.find { |c| can_target( c ) } != nil
  end

  def can_target(target)
      target.is_a?(Creature) && target.in_play? && ( target.flags[:attacking] || target.flags[:blocking] )
  end

  def pay!
    card.tap!
  end

  def required_targets
    1
  end

  def execute!
    super
    target.attack +=  1
    target.health +=  1
  end

  def value
    2
  end

end
