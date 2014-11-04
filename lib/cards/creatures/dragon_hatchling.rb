class DragonHatchling < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Dragon Hatchling"
    @strength = 0
    @toughness = 1
    @type = "Creature"
    @cost = 2 # 1R
    @description =  "Flying {Red}: Dragon Hatchling gets +1/+0 until end of turn."
    @img = "http://img0106.popscreencdn.com/155272845_collectable---ornate-gothic-hatching-dragon-egg---.jpg"
    @mtg_id = 259201
    add_abilities [Flying, BoostAttack]
  end

end
