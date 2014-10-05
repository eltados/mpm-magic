
class ConcordantCrossroads < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Concordant Crossroads"

    @cost = 1 # G
    @description =  "All creatures have haste."
    @img = "cards/1519.png"
    @mtg_id = 1519
  end

  def play!
    super
    world.enchantments << self
  end

  def affects(card)
    card.is_a?(Creature) && card.player == self.player && card.in_play?
  end

  def provided_abilities
    [PlusOnePlusOne]
  end


end
