class ElvishMystic < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Elvish Mystic"
    @strength = 1
    @toughness = 1
    @type = "Creature"
    @cost = 2 # G
    @description =  "{Tap}: Add {Green} to your mana pool."
    @img = "http://media.wizards.com/images/magic/daily/wallpapers/da1288_thumb.jpg"
    @mtg_id = 370744
    add_abilities [ProduceAbility]
  end

end
