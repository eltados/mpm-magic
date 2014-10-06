
class PhyrexianArena < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Phyrexian Arena"

    @cost = 3 # 1BB
    @description =  "At the beginning of your upkeep, you draw a card and you lose 1 life."
    @img = "cards/45339.png"
    @mtg_id = 45339
  end

  def self.disabled?; true end

end
    