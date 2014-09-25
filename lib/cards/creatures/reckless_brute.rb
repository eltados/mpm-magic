class RecklessBrute < Creature

  def initialize(owner=nil)
    super(owner=nil)
    @name = "Reckless Brute"
    @strength = 3
    @toughness = 1
    @type = "Creature"
    @cost = 3 # 2R
    @description =  "Haste (This creature can attack and {Tap} as soon as it comes under your control.) Reckless Brute attacks each turn if able."
    @img = "http://www.artofmtg.com/wp-content/uploads/2014/06/Headless-Skaab-MtG-300x300.jpg"
    @mtg_id = 253715
    add_abilities [Haste]
  end

end
