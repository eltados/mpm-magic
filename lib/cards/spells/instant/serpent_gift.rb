class  SerpentGift < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Serpent\'s Gift'
    @cost = 3 # 2G
    @description =  "Target creature gains deathtouch until end of turn."
    @img = "cards/249666.png"
  end

  def play!
    super
    player.target_action = TargetAction.new(self, self)
  end

  def can_target(target)
    target.is_a? Creature
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def execute_with_target!(target)
    super(target)
    target.add_temp_abilities  [ DeathTouch ]
  end


end
