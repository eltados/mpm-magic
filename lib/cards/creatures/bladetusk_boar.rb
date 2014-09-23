class BladetuskBoar < Creature
 #http://mtgsalvation.gamepedia.com/Mob_Rule
  def initialize(owner=nil)
    super(owner)
    @name = "Bladetusk Boar"
    @strength = 3
    @toughness = 2
    @type = "Creature"
    @cost = 4 # 3R
    @description =  "Intimidate (This creature can't be blocked except by artifact creatures and/or creatures that share a color with it.)"
    @img = "http://www.artofmtg.com/wp-content/uploads/2014/04/Bladetusk-Boar-Art-300x300.jpg"
    @mtg_id = 180350
  end

end
