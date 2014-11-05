class VulturousZombie < Creature

  def initialize(owner=nil)
    super(owner)
    @name = 'Vulturous Zombie'
    @strength = 3
    @toughness = 3
    @cost = 5 # 3BG
    @description =  "Flying Whenever a card is put into an opponent's graveyard from anywhere, put a +1/+1 counter on Vulturous Zombie."
    @img = "http://www.wizards.com/magic/images/cardart/ALA/Predator_Dragon.jpg"
    @mtg_id = 89082
    add_abilities [ Flying ]
  end

end
