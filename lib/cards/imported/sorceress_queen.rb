
class SorceressQueen < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Sorceress Queen"

    @strength = 1
    @toughness = 1
    @cost = 3 # 1BB
    @description =  "{Tap}: Target creature other than Sorceress Queen becomes 0/2 until end of turn."
    @img = "cards/926.png"
    @mtg_id = 926
  end

  def self.disabled?; true end

end
    