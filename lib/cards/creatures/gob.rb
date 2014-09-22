class Gob < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Gob"
    @strength = 2
    @toughness = 2
    @cost = 2
    @img = "http://bibliotheque-imperiale.com/images/thumb/4/42/Gobelinnuit.png/300px-Gobelinnuit.png";
    add_abilities  [ Haste ]
  end

end
