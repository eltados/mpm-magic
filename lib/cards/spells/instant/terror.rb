class  Terror < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Terror'
    @cost = 3 # 2G
    @description =  "Destroy target creature."
    @img = "http://fc07.deviantart.net/images/i/2003/6/8/7/Magic_The_Gathering_painting.jpg"
  end

  def can_target(target)
    target.is_a? Creature
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def play!
    super
    target.destroy!
  end

  def positive?
    false
  end

end
