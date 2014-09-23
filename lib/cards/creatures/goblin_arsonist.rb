class GoblinArsonist < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Goblin Arsonist"
    @strength = 1
    @toughness = 1
    @type = "Creature"
    @cost = 1 # R
    @description =  "When Goblin Arsonist is put into a graveyard from the battlefield, you may have it deal 1 damage to target creature or player."
    @img = "http://deathmarked.info/wp-content/uploads/2011/12/136.jpg"
    @mtg_id = 194902
  end

end
