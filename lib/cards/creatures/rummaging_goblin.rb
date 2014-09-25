class RummagingGoblin < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Rummaging Goblin"
    @strength = 1
    @toughness = 1
    @type = "Creature"
    @cost = 3 # 2R
    @description =  "{Tap}, Discard a card: Draw a card."
    @img = "http://images.rtsguru.com/articles/images/3000/2683/popup/techies.jpg"
    @mtg_id = 249705
  end

end
