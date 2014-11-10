
class ConcordantCrossroads < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Concordant Crossroads"

    @cost = 1 # G
    @description =  "All creatures ( including your opponent's ) have haste."
    @img = "cards/1519.png"
    @mtg_id = 1519
  end

  def play!
    super
  end

  def affects(card)
    card.is_a?(Creature)  && card.in_play?
  end

  def provided_abilities
    [Haste]
  end


end
