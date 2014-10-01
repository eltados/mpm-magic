class MoggFlunkies < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Mogg Flunkies"
    @strength = 3
    @toughness = 3
    @type = "Creature"
    @cost = 4 # 1R
    @description =  "Mogg Flunkies can't attack or block alone."
    @img = "http://mtgimage.com/set/pd2/mogg flunkies.crop.jpg"
    @mtg_id = 5100
  end

end
