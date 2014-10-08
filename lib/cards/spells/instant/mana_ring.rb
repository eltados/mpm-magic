class  ManaRing  < Instant


  def initialize(owner=nil)
    super(owner)
    @name = 'Mana Ring'
    @cost =  0
    @description =  "As you are the second player get 1 mana for free once."
    @img = "cards/mana_ring.png"
  end

  def play!
    super
    player.mana_pool.mana += 1
  end

  def self.disabled?
    true
  end

end
