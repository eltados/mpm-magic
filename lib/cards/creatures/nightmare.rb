class Nightmare < Creature

  def initialize(owner=nil)
    super(owner)
    @name = 'Nightmare'
    @strength = 5
    @toughness = 5
    @type = "Creature"
    @cost = 6 # 5B
    @description =  "Flying Nightmare's power and toughness are each equal to the number of Swamps you control."
    @img = "http://images4.wikia.nocookie.net/__cb20080929221314/traitorgame/images/4/41/Nightmare02.jpg"
    @mtg_id = 74
    add_ability(Flying.new)
  end

end
