class GloriousAnthem < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = 'Glorious Anthem'
    @cost = 3 # B
    @description =  "Creatures you control get +1/+1."
    @img = "cards/5835.png"
  end


  def affects(card)
    card.is_a?(Creature) && card.player == self.player && card.in_play?
  end

  def provided_abilities
    [PlusOnePlusOne]
  end


end
