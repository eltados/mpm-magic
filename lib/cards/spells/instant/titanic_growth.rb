class  TitanicGrowth < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Titanic Growth'
    @cost = 2 # 1B
    @description =  "Target creature gets +4/+4 until end of turn."
    @img = "cards/221203.png"
  end

  def play!
    super
    player.target_action = TargetAction.new(self, self)
  end

  def can_target(target)
    target.is_a? Creature
  end

  def can_be_played
    owner.mana_pool.can_pay?(self.cost) && [player.opponent.creatures, player.creatures ].flatten.any?{ |p| self.can_target(p) }
  end

  def execute_with_target!(target)
    super(target)
    target.attack_bonus += 4
    target.dmg -= 4 # a bit hacky
  end

end
