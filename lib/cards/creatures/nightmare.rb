class Nightmare < Creature

  def initialize(owner=nil)
    super(owner)
    @name = 'Nightmare'
    @strength = 0
    @toughness = 0
    @cost = 6 # 5B
    @description =  "Flying Nightmare's power and toughness are each equal to the number of Swamps you control."
    @img = "http://images4.wikia.nocookie.net/__cb20080929221314/traitorgame/images/4/41/Nightmare02.jpg"
    @mtg_id = 74
    add_abilities [ Flying , NightmareAbility ]
  end



end
