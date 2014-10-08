
class SyggRiverCutthroat < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Sygg, River Cutthroat"

    @cost = 2 # {B/U}{B/U}
    @description =  "At the beginning of each end step, if an opponent lost 3 or more life this turn, you may draw a card. (Damage causes loss of life.)"
    @img = "cards/147377.png"
    @mtg_id = 147377
  end

  def self.disabled?; true end

end
