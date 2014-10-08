class GloriousAnthem < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = 'Glorious Anthem'
    @cost = 3 # B
    @description =  "Creatures you control get +1/+1."
    @img = "http://ts1.mm.bing.net/th?&id=HN.608047655796149263&w=300&h=300&c=0&pid=1.9&rs=0&p=0"
  end

  def play!
    super
  end


  def affects(card)
    card.is_a?(Creature) && card.player == self.player && card.in_play?
  end

  def provided_abilities
    [PlusOnePlusOne]
  end


end
