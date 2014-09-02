class God < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "God"
    @strength = 1
    @toughness = 1
    @type = "god"
    @cost = 0
    @img = "http://cache.desktopnexus.com/thumbnails/488920-bigthumbnail.jpg"
    add_abilities  [ LifeLink, Trample, Boost, Flying, Haste, NightmareAbility,  ] # WallAbility ]
  end


end
