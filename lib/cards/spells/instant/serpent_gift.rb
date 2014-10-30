class  SerpentGift < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Serpent\'s Gift'
    @cost = 3 # 2G
    @description =  "Target creature gains deathtouch until end of turn."
    @img = "cards/249666.png"
  end

  def can_target(target)
    target.is_a?(Creature) && target.in_play?
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def play!(target)
    super
    target.add_temp_abilities  [ DeathTouch ]
  end


end
