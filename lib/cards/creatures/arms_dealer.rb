class ArmsDealer < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Arms Dealer"
    @strength = 1
    @toughness = 1
    @type = "Creature"
    @cost = 3 # 2R
    @description =  "{1}{Red}, Sacrifice a Goblin: Arms Dealer deals 4 damage to target creature."
    @img = "http://hextcg.com/wp-content/uploads/2013/05/Goblin-243x300.jpg"
    @mtg_id = 19861
    add_abilities [SacrificeHit]
  end

end
