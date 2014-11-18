class Mob < Creature

  def initialize(owner=nil)
    super(owner)
    @name = 'Mob'
    @strength = 1
    @toughness = 1
    @cost = 2 # G
    @description =  ""
    @img = "http://www.tentonhammer.com/image/view/50524"
    @mtg_id = 233052
    add_abilities [ Haste,DeathTouch ]
  end

end
