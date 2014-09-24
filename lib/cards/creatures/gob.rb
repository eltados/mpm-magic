class Gob < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Gob"
    @strength = 1
    @toughness = 1
    @cost = 1
    @img = "http://bibliotheque-imperiale.com/images/thumb/4/42/Gobelinnuit.png/300px-Gobelinnuit.png";
    add_abilities  [  ]
  end

end
