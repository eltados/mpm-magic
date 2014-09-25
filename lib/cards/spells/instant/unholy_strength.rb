# super hack enchant
class  UnholyStrength < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Unholy Strength'
    @cost = 1 # B
    @description =  "Enchanted creature gets +2/+1."
    @img = "http://ts1.mm.bing.net/th?&id=HN.608005672480541004&w=300&h=300&c=0&pid=1.9&rs=0&p=0"
  end

  def play!
    super
    player.target_action = TargetAction.new(self, self)
  end


  def can_target(target)
    target.is_a? Creature
  end

  def can_be_played
    owner.playing? && ( phase.is_a?(Pre) || phase.is_a?(Post) ) \
    && owner.mana_pool.can_pay?(self.cost) \
    && [player.opponent.creatures, player.creatures ].flatten.any?{ |p| self.can_target(p) }
  end

  def execute_with_target!(target)
    super(target)
    target.strength += 2
    target.toughness += 1
  end

end
