class  UnholyStrength < Sorcery


  def initialize(owner=nil)
    super(owner)
    @name = 'Unholy Strength'
    @cost = 1 # B
    @description =  "Enchanted creature gets +2/+1."
    @img = "cards/87.png"
  end

  def can_target(target)
    target.is_a? Creature
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def play_with_target!(target)
    super(target)
    target.strength += 2
    target.toughness += 1
  end

end
