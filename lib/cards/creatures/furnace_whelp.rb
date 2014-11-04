class FurnaceWhelp < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Furnace Whelp"
    @strength = 2
    @toughness = 2
    @type = "Creature"
    @cost = 4 # 2RR
    @description =  "Flying (This creature can't be blocked except by creatures with flying or reach.) {Red}: Furnace Whelp gets +1/+0 until end of turn."
    @img = "http://www.artofmtg.com/wp-content/uploads/2014/06/Furnace-Whelp-MtG-Art-300x300.jpg"
    @mtg_id = 73578
    add_abilities [Flying, BoostAttack]
  end

end
