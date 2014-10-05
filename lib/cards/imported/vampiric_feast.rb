
class VampiricFeast < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Vampiric Feast"

    @cost = 7 # 5BB
    @description =  "Vampiric Feast deals 4 damage to target creature or player and you gain 4 life."
    @img = "cards/4243.png"
    @mtg_id = 4243
  end

  def disabled?; true end

end
