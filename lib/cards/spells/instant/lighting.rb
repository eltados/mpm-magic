class  Lighting < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Lighting'
    @cost = 1 # 5B
    @description =  "Deals 3 damages to target creature"
    @img = "http://images2.layoutsparks.com/1/44124/nerve-confusion-red-lightning.gif"
  end


  def play!
    super
    target.hit! 3
  end


  def can_target(target)
    target.is_a?(Creature) && target.in_play?
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def positive?
    false
  end

end
